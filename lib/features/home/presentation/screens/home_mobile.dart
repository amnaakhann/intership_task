import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:task/core/theme/app_colors.dart';
import 'package:task/core/theme/app_text_styles.dart';
import 'package:task/features/home/domain/entities/carousel_item.dart';
import 'package:task/features/home/domain/entities/quick_card_entity.dart';
import 'package:task/features/auth/presentation/providers/auth_provider.dart';
import 'package:task/features/home/presentation/widgets/home_header.dart';
import 'package:task/features/home/presentation/widgets/home_carousel.dart';
import 'package:task/features/home/presentation/widgets/quick_card_widget.dart';

/// Home screen - mobile layout with carousel and search functionality
class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<CarouselItem> _carouselItems = const [
    CarouselItem(
      gradient: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
      title: 'Discover Recipes',
      subtitle: 'Find your perfect meal today',
      icon: Icons.restaurant_menu_rounded,
    ),
    CarouselItem(
      gradient: [Color(0xFFFF6584), Color(0xFFFF8C61)],
      title: 'Cook with Passion',
      subtitle: 'Step-by-step cooking guides',
      icon: Icons.local_fire_department_rounded,
    ),
    CarouselItem(
      gradient: [Color(0xFF43E97B), Color(0xFF38F9D7)],
      title: 'Eat Healthy',
      subtitle: 'Nutritious meals for every day',
      icon: Icons.eco_rounded,
    ),
  ];

  final List<QuickCardEntity> _quickCards = const [
    QuickCardEntity(
      name: 'Pasta Carbonara',
      time: '20 min',
      icon: Icons.timer_outlined,
      bgColor: Color(0xFFFFF3E0),
    ),
    QuickCardEntity(
      name: 'Green Salad',
      time: '10 min',
      icon: Icons.eco_outlined,
      bgColor: Color(0xFFE8F5E9),
    ),
    QuickCardEntity(
      name: 'Berry Smoothie',
      time: '5 min',
      icon: Icons.blender_outlined,
      bgColor: Color(0xFFF3E5F5),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(
              isSearching: _isSearching,
              searchController: _searchController,
              onLogout: () {
                context.read<AuthProvider>().logout();
              },
              onSearchToggle: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) _searchController.clear();
                });
              },
              onSearchSubmitted: (value) {
                setState(() {
                  _isSearching = false;
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    HomeCarousel(
                      items: _carouselItems,
                      currentIndex: _currentCarouselIndex,
                      controller: _carouselController,
                      onPageChanged: (index, reason) =>
                          setState(() => _currentCarouselIndex = index),
                    ),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Popular This Week'),
                    const SizedBox(height: 12),
                    _buildQuickCardsList(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.heading3),
          Text(
            'See all',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCardsList() {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _quickCards.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) => QuickCardWidget(card: _quickCards[index]),
      ),
    );
  }
}
