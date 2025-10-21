import 'package:flutter/material.dart';

class TrainingCard extends StatelessWidget {
  final DateTime? date;
  final int? mood;
  final String? score;
  final bool showHeader;
  final String? headerTitle;
  final VoidCallback? onTap;
  final bool showSeeAll;

  const TrainingCard({
    super.key,
    this.showHeader = false,
    this.headerTitle,
    this.onTap,
    this.showSeeAll = false, 
    this.date, 
    required this.mood, 
    required this.score,
  });

  /// Helper method to check if the training was done today
  bool _isToday(DateTime trainingDate) {
    final now = DateTime.now();
    return trainingDate.year == now.year &&
        trainingDate.month == now.month &&
        trainingDate.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final isTrainingToday = date != null && _isToday(date!);
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with optional "See all" button
              if (showHeader) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        headerTitle ?? "Today's training",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    if (showSeeAll) ...[
                      Text(
                        'See all',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 30),
              ],
              
              // Main content - Fixed logic for showing training or "no training" message
              if (showHeader && (date == null || !isTrainingToday))
                Text(
                  'No training done today yet',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                )
              else if (date != null) ...[
                // Date display for non-header view
                if (!showHeader)
                  Text(
                    isTrainingToday ? 'Today' : '${date!.day}.${date!.month}.${date!.year}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                
                if (!showHeader) const SizedBox(height: 30),
                
                // Time
                Text(
                  '${date!.hour.toString().padLeft(2, '0')}:${date!.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Mood and Score badges
                Row(
                  children: [
                    // Mood badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Mood: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            TextSpan(
                              text: mood.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Score badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Score: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            TextSpan(
                              text: score,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
