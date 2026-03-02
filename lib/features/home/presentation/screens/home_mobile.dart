import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Home screen - mobile layout with carousel and vertical side search bar
class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController =
  CarouselSliderController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<_CarouselItem> _carouselItems = const [
    _CarouselItem(
      gradient: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
      title: 'Discover Recipes',
      subtitle: 'Find your perfect meal today',
      icon: Icons.restaurant_menu_rounded,
    ),
    _CarouselItem(
      gradient: [Color(0xFFFF6584), Color(0xFFFF8C61)],
      title: 'Cook with Passion',
      subtitle: 'Step-by-step cooking guides',
      icon: Icons.local_fire_department_rounded,
    ),
    _CarouselItem(
      gradient: [Color(0xFF43E97B), Color(0xFF38F9D7)],
      title: 'Eat Healthy',
      subtitle: 'Nutritious meals for every day',
      icon: Icons.eco_rounded,
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
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildCarousel(),
                    const SizedBox(height: 16),
                    _buildCarouselIndicator(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Popular This Week'),
                    const SizedBox(height: 12),
                    _buildQuickCards(),
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

  Widget _buildHeader(BuildContext context) {
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
      child: _isSearching ? _buildSearchHeader() : _buildDefaultHeader(context),
    );
  }

  Widget _buildDefaultHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
              ),
            ],
          ),
          Row(
            children: [
              _buildHeaderIcon(
                icon: Icons.search_rounded,
                onTap: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
              const SizedBox(width: 12),
              _buildHeaderIcon(
                icon: Icons.notifications_none_rounded,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = false;
                _searchController.clear();
              });
            },
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
                controller: _searchController,
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
                onSubmitted: (value) {
                  // Perform search
                  setState(() {
                    _isSearching = false;
                  });
                },
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
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: _carouselItems.length,
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.88,
        enlargeCenterPage: true,
        enlargeFactor: 0.18,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOutCubic,
        onPageChanged: (index, reason) =>
            setState(() => _currentCarouselIndex = index),
      ),
      itemBuilder: (context, index, realIndex) {
        final item = _carouselItems[index];
        return _buildCarouselCard(item);
      },
    );
  }

  Widget _buildCarouselCard(_CarouselItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: item.gradient.first.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 14),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Explore button
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.4)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselIndicator() {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: _currentCarouselIndex,
        count: _carouselItems.length,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.primary,
          dotColor: AppColors.primary.withOpacity(0.25),
          dotHeight: 8,
          dotWidth: 8,
          expansionFactor: 3,
          spacing: 5,
        ),
        onDotClicked: (index) {
          _carouselController.animateToPage(index);
        },
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

  Widget _buildQuickCards() {
    final cards = [
      _QuickCard('Pasta Carbonara', '20 min', Icons.timer_outlined,
          const Color(0xFFFFF3E0)),
      _QuickCard('Green Salad', '10 min', Icons.eco_outlined,
          const Color(0xFFE8F5E9)),
      _QuickCard('Berry Smoothie', '5 min', Icons.blender_outlined,
          const Color(0xFFF3E5F5)),
    ];

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) => _buildQuickCard(cards[index]),
      ),
    );
  }

  Widget _buildQuickCard(_QuickCard card) {
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
          const Spacer(),
          Text(
            card.name,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.schedule_rounded,
                  size: 12, color: AppColors.textSecondary),
              const SizedBox(width: 3),
              Text(card.time, style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }

}


class _CarouselItem {
  final List<Color> gradient;
  final String title;
  final String subtitle;
  final IconData icon;

  const _CarouselItem({
    required this.gradient,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class _QuickCard {
  final String name;
  final String time;
  final IconData icon;
  final Color bgColor;

  const _QuickCard(this.name, this.time, this.icon, this.bgColor);
}
