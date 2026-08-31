// lib/core/widgets/skeleton_card.dart
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Generic skeleton-loading card used across dashboard, assessment results,
/// and hospital bag screens while Drift streams are still emitting their
/// first value.
///
/// Usage:
/// ```dart
/// asyncScores.when(
///   data: (scores) => CategoryCard(scores: scores),
///   loading: () => const SkeletonCard(lineCount: 3),
///   error: (e, st) => ErrorCard(message: e.toString()),
/// );
/// ```
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
    this.lineCount = 2,
    this.hasLeadingIcon = true,
    this.height,
  });

  /// Number of placeholder text lines to render inside the card body.
  final int lineCount;

  /// Whether to reserve space for a leading icon/avatar, matching cards
  /// that pair a category icon with text (accessibility requirement).
  final bool hasLeadingIcon;

  /// Optional fixed height; defaults to intrinsic content height.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasLeadingIcon) ...[
                  const CircleAvatar(radius: 22),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (int i = 0; i < lineCount; i++) ...[
                        Container(
                          width: i.isEven ? double.infinity : 140,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Convenience widget for a vertical list of skeleton cards
/// (e.g. dashboard's 7-category summary while loading).
class SkeletonCardList extends StatelessWidget {
  const SkeletonCardList({
    super.key,
    this.itemCount = 4,
    this.lineCount = 2,
  });

  final int itemCount;
  final int lineCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => SkeletonCard(lineCount: lineCount),
    );
  }
}