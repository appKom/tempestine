import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:online/components/image_default.dart';

import '/components/animated_button.dart';
import '/components/icon_label.dart';
import '/components/skeleton_loader.dart';
import '/core/models/article_model.dart';
import '/theme/theme.dart';

class ArticleCarousel extends StatelessWidget {
  final List<ArticleModel> articles;
  const ArticleCarousel({super.key, required this.articles});

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static const _wordsPerMinute = 238;
  static const _minReadingTime = 1;

  static int _calculateReadingTime(String heading, String ingress) {
    final wordCount = _countWords(heading) + _countWords(ingress);
    return ((wordCount / _wordsPerMinute) + _minReadingTime).ceil();
  }

  static int _countWords(String text) {
    return text.split(' ').where((word) => word.isNotEmpty).length;
  }

  static String _formatDate(ArticleModel article) {
    final date = DateTime.parse(article.createdDate);
    final day = date.day.toString().padLeft(2, '0');
    final month = _months[date.month - 1];
    return '$day. $month';
  }

  static CarouselOptions _getCarouselOptions(BuildContext context) {
    final isMobile = OnlineTheme.isMobile(context);
    return CarouselOptions(
      height: 300,
      enableInfiniteScroll: true,
      padEnds: true,
      enlargeCenterPage: false,
      viewportFraction: isMobile ? 0.75 : 0.3,
      clipBehavior: Clip.none,
    );
  }

  static Widget skeleton(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
        3,
        (_) => const SkeletonLoader(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      options: _getCarouselOptions(context),
    );
  }

  Widget _buildCoverImage(ArticleModel article) {
    if (article.image?.original == null) {
      return const ImageDefault();
    }

    return CachedNetworkImage(
      imageUrl: article.image!.original,
      placeholder: (_, __) => const SkeletonLoader(),
      errorWidget: (_, __, ___) => const ImageDefault(),
    );
  }

  Widget _buildArticleCard(ArticleModel article, BuildContext context) {
    final timeToRead = _calculateReadingTime(article.content, article.ingress);

    return AnimatedButton(
      onTap: () => context.go('/articles/${article.createdDate}'),
      childBuilder: (context, hover, pointerDown) {
        return Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(width: 2, color: OnlineTheme.current.border),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImageSection(article),
                _buildContentSection(article, timeToRead),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection(ArticleModel article) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: OnlineTheme.current.border)),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _buildCoverImage(article),
      ),
    );
  }

  Widget _buildContentSection(ArticleModel article, int timeToRead) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              article.heading,
              style: OnlineTheme.subHeader(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconLabelLucide(
                  icon: LucideIcons.calendar_fold,
                  label: _formatDate(article),
                ),
                IconLabelLucide(
                  icon: LucideIcons.clock,
                  label: '$timeToRead min',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: _getCarouselOptions(context),
      items: articles.map((article) => _buildArticleCard(article, context)).toList(),
    );
  }
}
