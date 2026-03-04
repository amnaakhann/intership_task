import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/carousel_item.dart';

class HomeCarousel extends StatelessWidget {
  final List<CarouselItem> items;
  final int currentIndex;
  final CarouselSliderController controller;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  const HomeCarousel({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: items.length,
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
            onPageChanged: onPageChanged,
          ),
          itemBuilder: (context, index, realIndex) {
            final item = items[index];
            return _buildCarouselCard(item);
          },
        ),
        const SizedBox(height: 16),
        _buildCarouselIndicator(),
      ],
    );
  }

  Widget _buildCarouselCard(CarouselItem item) {
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
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    return AnimatedSmoothIndicator(
      activeIndex: currentIndex,
      count: items.length,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.primary,
        dotColor: AppColors.primary.withOpacity(0.25),
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 3,
        spacing: 5,
      ),
      onDotClicked: (index) {
        controller.animateToPage(index);
      },
    );
  }
}
