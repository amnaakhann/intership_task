import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final VoidCallback onSearchToggle;
  final Function(String) onSearchSubmitted;
  final VoidCallback? onLogout;

  const HomeHeader({
    super.key,
    required this.isSearching,
    required this.searchController,
    required this.onSearchToggle,
    required this.onSearchSubmitted,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: isSearching ? _buildSearchHeader(context) : _buildDefaultHeader(context),
    );
  }

  Widget _buildDefaultHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: AppTextStyles.heading1.copyWith(
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [AppColors.primary, Color(0xFF3B82F6)],
                      ).createShader(const Rect.fromLTWH(0, 0, 150, 50)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'What are you cooking today?',
                  style: AppTextStyles.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderIcon(
                icon: Icons.search_rounded,
                onTap: onSearchToggle,
              ),
              const SizedBox(width: 8),
              _buildHeaderIcon(
                icon: Icons.notifications_none_rounded,
                onTap: () {},
              ),
              if (onLogout != null) ...[
                const SizedBox(width: 8),
                _buildHeaderIcon(
                  icon: Icons.logout_rounded,
                  onTap: onLogout!,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onSearchToggle,
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary, size: 20),
          ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                autofocus: true,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppColors.primary, size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 11),
                ),
                onSubmitted: onSearchSubmitted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
