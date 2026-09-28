# tools/verify_question_bank.py
"""Verify the committed question bank against the master PDF.

WHY THIS EXISTS
---------------
`lib/features/assessment/data/question_bank.dart` and the `questions` blocks in
`assets/i18n/{en,fil}.json` are hand-transcribed from `ReadyMama Contents.pdf`.
Hand transcription is exactly the kind of task that silently produces
plausible-looking errors. While building this bank, a first draft was diffed
mechanically and turned up 6 real defects that reading it over had missed:

  * 5 option transpositions in Delivery Plan (Q1, Q3, Q8, Q9, Q10, in BOTH
    languages) where options had been listed in rank order rather than the
    PDF's display order, so C/D and B/C were swapped;
  * 1 Tagalog typo ("kinabukusan" for the source's "kinabukasan").

Those were all invisible on inspection. This script exists so the next person
who edits the bank gets the same check instead of trusting their eyes.

WHAT IT CHECKS
--------------
  1. Structure — bank sizes, id/key shape, one rank-1 option per question,
     ranks exactly 1..N, option counts within 2-4, Danger Signs rank 1 pinned
     to display position 0 and carrying a null category.
  2. Source fidelity — every prompt and option in en.json and fil.json is
     diffed against the text extracted from the PDF. Nothing may be
     paraphrased or "cleaned up": the PDF's typos are the content.

It reads the *committed* Dart and JSON, not any generator's internal state, so
it stays meaningful even if the scripts that produced them are deleted.

USAGE
-----
    python tools/verify_question_bank.py
    python tools/verify_question_bank.py --pdf "some/other/ReadyMama Contents.pdf"

Requires `pdftotext` (poppler) on PATH. Exits 0 when everything matches, 1
otherwise.
"""
import argparse
import io
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DART_BANK = os.path.join(REPO, 'lib', 'features', 'assessment', 'data',
                         'question_bank.dart')
EN_JSON = os.path.join(REPO, 'assets', 'i18n', 'en.json')
FIL_JSON = os.path.join(REPO, 'assets', 'i18n', 'fil.json')
DEFAULT_PDF = os.path.join(REPO, 'ReadyMama Contents.pdf')

# Bank symbol -> (i18n category, scored?, question number in the source)
BANKS = [
    ('deliveryPlanQuestions', 'delivery_plan', True),
    ('hospitalBagQuestions', 'hospital_bag', True),
    ('emergencyPlanQuestions', 'emergency_plan', True),
    ('selfPreparednessQuestions', 'self_preparedness', True),
    ('supportPersonQuestions', 'support_person', True),
    ('dangerSignQuestions', 'danger_signs', False),
]

# Per-section PDF page ranges (1-based, inclusive) that hold the QUESTIONNAIRE
# only. Education/LEARN prose and the scoring-key blocks in between are
# deliberately excluded: they are not questions and would otherwise be
# mistaken for option text.
#
# Most categories interleave EN and FIL on the same pages, so one range yields
# two runs per question. For Self-Preparedness the languages sit on separate
# pages (42-43 = EN, 49-50 = FIL) with education prose squeezed between, so
# two ranges are given: (EN, FIL).
SECTIONS = {
    'delivery_plan':       ((2, 7)),
    'hospital_bag':        ((9, 12)),
    'emergency_plan':      ((28, 32)),
    'danger_signs':        ((34, 40)),
    'self_preparedness':   ((42, 43), (49, 50)),
    'support_person':      ((56, 61)),
}

# Support Person and Self-Preparedness use indented option lines (" Yes",
# " Strongly Agree") rather than "A."/"B." letters.
LETTERLESS = {'support_person', 'self_preparedness'}

# Marks where a scoring key / checklist / reference list begins. Everything up
# to the next question belongs to that block, not to the options.
STOP_AT = re.compile(
    r'\b(checklist|gabay sa pagmamarka|answer key|best answers|references:)\b',
    re.I)
# "No If yes, who? ____" is one option plus one fill-in blank.
SPLIT_BLANK = re.compile(r'\s*(if yes, who\?|kung oo, sino\?).*$', re.I)

Q_RE = re.compile(r'^\s*(\d{1,2})\s*[\.\)]\s*(\S.*)$')
OPT_RE = re.compile(r'^\s*([A-Da-d])\s*[\.\)]\s+(\S.*)$')
JUNK = re.compile(
    r'^\s*(#{3,}\s*PAGE|-{3,}|\(\s*(English|Tagalog|Filipino)\s*\)'
    r'|TAGALOG TRANSLATION:|\[\s*TAGALOG VER\.\s*\]|INSTRUCTIONS?:|Instructions:'
    r'|LEARNING|DOCUMENT DATE:|Document Date:|Pregnancy Danger Signs\?'
    r'|EDUCATION/LEARN|\(QUESTIONS\)|\bQUESTIONS\b|\(Questions\))', re.I)

problems = []
checked = [0]


def fail(msg):
    problems.append(msg)


# --------------------------------------------------------------------------
# normalisation
# --------------------------------------------------------------------------
def norm(s):
    """Collapse whitespace/typography so only real text differences show."""
    s = (s.replace('\u2019', "'").replace('\u2018', "'")
          .replace('\u201c', '"').replace('\u201d', '"')
          .replace('\u2013', '-').replace('\u2014', '-'))
    s = re.sub(r'\s+', ' ', s).strip().lower()
    return s.rstrip('.').strip()


# --------------------------------------------------------------------------
# PDF text -> {question number:
#                [{'prompt': str, 'options': [(letter, text), ...]}, ...]}
# --------------------------------------------------------------------------
def parse_questions(text, letterless=False):
    out, cur, last, prev = {}, None, None, None
    in_trailer = False
    prompt_pending = False
    for raw in text.splitlines():
        line = SPLIT_BLANK.sub('', raw.rstrip()).rstrip()
        if not line.strip() or JUNK.match(line):
            continue
        if STOP_AT.search(line):
            in_trailer, last, prompt_pending = True, None, False
            continue

        m = Q_RE.match(line)
        # "1.A" / "10.B" in a scoring-key block is not a question.
        if m and len(m.group(2).split()) == 1 and len(m.group(2)) <= 2:
            last, prompt_pending = None, False
            continue
        if m and not (not letterless and OPT_RE.match(line)):
            n = int(m.group(1))
            if n != prev:
                # A repeated question number means a new language run: start a
                # fresh occurrence so EN and FIL never merge into one list.
                out.setdefault(n, []).append({'prompt': m.group(2),
                                              'options': []})
                last = None
            cur, prev, in_trailer = n, n, False
            prompt_pending = True
            continue
        if cur is None or in_trailer:
            continue

        # Options come first: a line that is a valid option ends the prompt.
        if not letterless:
            m = OPT_RE.match(line)
            if m:
                out[cur][-1]['options'].append(
                    (m.group(1).lower(), m.group(2).strip()))
                last = out[cur][-1]['options'][-1]
                prompt_pending = False
                continue
        else:
            if line[0].isspace():
                out[cur][-1]['options'].append(('?', line.strip()))
                last = out[cur][-1]['options'][-1]
                prompt_pending = False
                continue

        # Continuation lines of the prompt are not options: they are indented
        # the same way letterless option lines are, so anything that is not a
        # recognised option and precedes the first option belongs to the prompt.
        if prompt_pending:
            out[cur][-1]['prompt'] += ' ' + line.strip()
            continue

        if last is not None:                    # wrapped continuation line
            last = (last[0], (last[1] + ' ' + line.strip()).strip())
            out[cur][-1]['options'][-1] = last
    return {n: occ for n, occ in out.items() if any(occ)}


def extract_pdf(pdf_path, first_page, last_page):
    """pdftotext a page range, minus the page-header lines it injects."""
    with tempfile.TemporaryDirectory() as tmp:
        out = os.path.join(tmp, 'sec.txt')
        subprocess.run(
            [shutil.which('pdftotext'), '-layout',
             '-f', str(first_page), '-l', str(last_page), pdf_path, out],
            check=True, capture_output=True)
        text = io.open(out, encoding='utf-8', errors='replace').read()
    return re.sub(r'^#{2,}\s*PAGE.*$', '', text, flags=re.M)


# --------------------------------------------------------------------------
# the committed Dart bank -> [{id, category, promptKey, options:[{suffix,rank}]}]
# --------------------------------------------------------------------------
def parse_dart(path):
    src = io.open(path, encoding='utf-8').read()
    banks = {}
    for symbol, _cat, _scored in BANKS:
        m = re.search(r'const List<Question> %s = \[(.*?)\n\];' % symbol,
                      src, re.S)
        if not m:
            fail('could not find %s in %s' % (symbol, path))
            banks[symbol] = []
            continue
        body = m.group(1)

        questions = []
        for qm in re.finditer(
                r'Question\(\s*id: "([^"]+)",\s*category: ([^,]+),\s*'
                r'promptKey: "([^"]+)",\s*options: \[(.*?)\n    \],', body, re.S):
            qid, category, prompt_key, opts = qm.groups()
            options = []
            for om in re.finditer(
                    r'QuestionOption\(\s*id: "([^"]+)",\s*labelKey: "([^"]+)",\s*'
                    r'rank: (\d+),', opts):
                oid, label_key, rank = om.groups()
                suffix = oid[len(qid) + 1:]        # strip "q...qN_"
                options.append({'suffix': suffix, 'id': oid,
                                'labelKey': label_key, 'rank': int(rank)})
            questions.append({
                'id': qid,
                'category': category.strip(),
                'promptKey': prompt_key,
                'num': int(re.search(r'q(\d+)$', qid).group(1)),
                'options': options,
            })
        banks[symbol] = questions
    return banks


# --------------------------------------------------------------------------
# checks
# --------------------------------------------------------------------------
def check_structure(symbols, en, fil):
    for symbol, cat, scored in BANKS:
        questions = symbols[symbol]
        expected = 9 if cat == 'support_person' else 10
        if len(questions) != expected:
            fail('%s: expected %d questions, found %d'
                 % (cat, expected, len(questions)))
        for q in questions:
            ranks = sorted(o['rank'] for o in q['options'])
            if ranks != list(range(1, len(q['options']) + 1)):
                fail('%s %s: ranks are %s, expected 1..%d'
                     % (cat, q['id'], ranks, len(q['options'])))
            if not (2 <= len(q['options']) <= 4):
                fail('%s %s: %d options, expected 2-4'
                     % (cat, q['id'], len(q['options'])))
            if sorted(o['rank'] for o in q['options']).count(1) != 1:
                fail('%s %s: must have exactly one rank-1 option'
                     % (cat, q['id']))
            for o in q['options']:
                if o['labelKey'] != q['promptKey'] + '_' + o['suffix']:
                    fail('%s %s: labelKey %r does not match promptKey + suffix'
                         % (cat, q['id'], o['labelKey']))
            if scored and q['category'] == 'null':
                fail('%s %s: scored question has a null category' % (cat, q['id']))
            if not scored and q['category'] != 'null':
                fail('%s %s: Danger Signs question must have a null category'
                     % (cat, q['id']))
            if not scored and q['options'][0]['rank'] != 1:
                fail('%s %s: rank 1 must stay pinned to display position 0 '
                     '(the screener treats option A as the danger sign)'
                     % (cat, q['id']))

    # namespace migration
    for path, data in (('en.json', en), ('fil.json', fil)):
        if 'sample_questions' in data:
            fail('%s still has the retired sample_questions namespace' % path)
        if 'questions' not in data:
            fail('%s has no questions namespace' % path)
    if 'questions' in en and 'questions' in fil:
        if set(en['questions']) != set(fil['questions']):
            fail('en.json and fil.json expose different categories')
        for cat in en['questions']:
            if set(en['questions'][cat]) != set(fil['questions'].get(cat, {})):
                fail('en.json and fil.json differ in keys for %s' % cat)


def check_fidelity(symbols, en, fil, pdf_path):
    for symbol, cat, _scored in BANKS:
        ranges = SECTIONS[cat]
        letterless = cat in LETTERLESS
        # One range => EN/FIL interleave; two (EN, FIL) ranges => separately.
        split = isinstance(ranges[0], tuple)
        parsed_all = None if split else \
            parse_questions(extract_pdf(pdf_path, *ranges), letterless)
        parsed_two = [parse_questions(extract_pdf(pdf_path, *r), letterless)
                      for r in ranges] if split else None
        questions = symbols[symbol]

        def locale_runs(num, locale):
            idx = 0 if locale == 'en' else 1
            # Only occurrences that actually carry options are real Q&A blocks;
            # numbered education bullets share the same numbers and must not
            # be mistaken for a language run.
            is_real = lambda occ: occ.get('options')
            if parsed_all is not None:
                runs = [o for o in parsed_all.get(num, []) if is_real(o)]
                if idx < len(runs):
                    return [runs[idx]]
                return []
            return [o for o in parsed_two[idx].get(num, []) if is_real(o)]

        for q in questions:
            stem = q['promptKey'].split('.', 2)[2]
            for locale in ('en', 'fil'):
                data = en if locale == 'en' else fil
                runs = locale_runs(q['num'], locale)
                if not runs:
                    fail('%s %s: question %d (%s) not found in the PDF'
                         % (cat, q['id'], q['num'], locale))
                    continue
                bucket = data.get('questions', {}).get(cat)
                if bucket is None:
                    fail('%s: %s.json has no entry for %s' % (cat, locale, q['id']))
                    continue

                # Prompt text must match the PDF run's prompt verbatim.
                pdf_prompt = runs[0]['prompt']
                if not pdf_prompt:
                    fail('%s %s %s: no prompt text found in the PDF'
                         % (cat, q['id'], locale))
                else:
                    checked[0] += 1
                    prompt = bucket.get(stem)
                    if prompt is None:
                        fail('%s: %s.json is missing %s' % (cat, locale,
                                                            q['promptKey']))
                    elif norm(pdf_prompt) != norm(prompt):
                        fail('%s %s %s: prompt = %r but the PDF says %r'
                             % (cat, q['id'], locale, prompt, pdf_prompt))

                for o in q['options']:
                    # JSON nests as questions.<category>.<stem>[_<suffix>], and
                    # `bucket` is already the per-category dict.
                    key = q['promptKey'].split('.', 2)[2] + '_' + o['suffix']
                    value = bucket.get(key)
                    if value is None:
                        fail('%s: %s.json is missing %s' % (cat, locale, key))
                        continue
                    checked[0] += 1
                    if not letterless and o['suffix'] in 'abcd':
                        hit = next((t for l, t in runs[0]['options']
                                    if l == o['suffix']), None)
                        if hit is None:
                            fail('%s %s %s: source has no option %r'
                                 % (cat, q['id'], locale, o['suffix'].upper()))
                            continue
                    else:
                        hit = next((t for _l, t in runs[0]['options']
                                    if norm(t) == norm(value)), None)
                        if hit is None:
                            fail('%s %s %s: %r is not among the source options %r'
                                 % (cat, q['id'], locale, value,
                                    [t for _l, t in runs[0]['options']]))
                            continue
                    if not norm(hit).startswith(norm(value)):
                        fail('%s %s %s: %s = %r but the PDF says %r'
                             % (cat, q['id'], locale, key, value, hit))


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--pdf', default=DEFAULT_PDF,
                    help='path to ReadyMama Contents.pdf '
                         '(default: %(default)s)')
    args = ap.parse_args()

    if not os.path.isfile(args.pdf):
        print('error: PDF not found: %s' % args.pdf)
        print('Pass --pdf <path> to point at the master content source.')
        return 2
    pdftotext = shutil.which('pdftotext')
    if not pdftotext:
        print('error: pdftotext not found on PATH (install poppler-utils)')
        return 2

    symbols = parse_dart(DART_BANK)
    en = json.load(io.open(EN_JSON, encoding='utf-8'))
    fil = json.load(io.open(FIL_JSON, encoding='utf-8'))

    check_structure(symbols, en, fil)
    check_fidelity(symbols, en, fil, args.pdf)

    total = sum(len(v) for v in symbols.values())
    print('checked %d questions and %d prompt/option strings against %s'
          % (total, checked[0], os.path.basename(args.pdf)))
    if not problems:
        print('*** ALL MATCH ***')
        return 0
    print('\n%d PROBLEM(S):\n' % len(problems))
    for p in problems:
        print('  ' + p)
    return 1


if __name__ == '__main__':
    sys.exit(main())
