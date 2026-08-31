# ReadyMAMA — AI Coding Directives

## Architecture (non-negotiable)
- Feature-first Clean Architecture. Every feature lives in `lib/features/<name>/`
  with its own `data/`, `domain/`, and `presentation/` subfolders.
- Shared code ONLY goes in `lib/core/`. Never let features import from each other
  directly — route shared logic through `core/`.
- State management: Riverpod ONLY (flutter_riverpod + riverpod_annotation).
  Use `@riverpod` codegen providers, not manual StateNotifierProvider boilerplate.
- Routing: GoRouter only, centralized in `lib/core/router/`.
- Persistence: Drift (SQLite) only, centralized in `lib/core/database/`.
  Never instantiate a second AppDatabase instance — always inject via Riverpod.

## Code generation
- Any change to a Drift table or a `@riverpod` annotated file requires running:
  `flutter pub run build_runner build --delete-conflicting-outputs`
- Never hand-write `.g.dart` files. If asked to edit one, edit the source
  annotation instead and regenerate.

## Localization
- No hardcoded user-facing strings. All strings pull from
  `assets/i18n/en.json` / `assets/i18n/fil.json` via the i18n service.
- When adding a new string, add it to BOTH locale files in the same key path,
  same session, never one without the other.

## Theming
- Primary brand color is ReadyMAMA Pink `#E91E63`. All colors reference
  `lib/core/theme/` — no inline `Color(0xFF...)` in feature widgets.

## Accessibility
- Any quiz option, checklist item, or danger-sign card must pair an icon/illustration
  with text — never text-only for assessment-facing UI (low-literacy requirement).

## Offline-first
- No network calls in Phase 1–3. All data reads/writes go through Drift DAOs.
  Treat any suggestion involving `http`/`dio` as out of scope unless explicitly asked.

## Sync discipline
- When generating new files, always output the FULL file with its path as a header
  comment on line 1, e.g. `// lib/features/assessment/domain/models/category.dart`
  This keeps manual copy-paste from Claude and local AI-tool edits reconcilable in git diffs.
- Prefer additive changes. Do not silently refactor unrelated files.