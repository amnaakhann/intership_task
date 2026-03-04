import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/quick_card_entity.dart';

class QuickCardWidget extends StatelessWidget {
  final QuickCardEntity card;

  const QuickCardWidget({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card.icon, size: 30, color: AppColors.primary),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              card.name,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.schedule_rounded,
                  size: 12, color: AppColors.textSecondary),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  card.time,
                  style: AppTextStyles.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
