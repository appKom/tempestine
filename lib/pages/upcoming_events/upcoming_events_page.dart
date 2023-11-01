import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_events/pages/upcoming_events/bedpress.dart';
import 'package:online_events/pages/upcoming_events/profile_button.dart';
import 'package:online_events/pages/upcoming_events/promoted_article.dart';

import 'more_events_page.dart';
import 'upcoming_events.dart';
import '/theme.dart';

class UpcomingEventsPage extends StatelessWidget {
  const UpcomingEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnlineScaffold(
      header: const ProfileButton(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PromotedArticle(),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          const SizedBox(
            height: 15,
            child: Center(
              child: Text('KOMMENDE ARRANGEMENTER',
                  style: OnlineTheme.UpcommingEventstext),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 242,
            child: UpcomingEventsList(
              models: testModels,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MoreEventsPage()),
                  );
                },
                child: Text(
                  'MER',
                  style: OnlineTheme.UpcommingEventstext.copyWith(
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 2),
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.navigate_next,
                  color: OnlineTheme.gray9,
                  size: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Bedpress(
            models: bedpressModels,
          ),
        ],
      ),
    );
  }
}

/// Online logo, valgfri header og scrollbart innhold med fade
class OnlineScaffold extends StatelessWidget {
  final Widget? header;
  final Widget content;

  const OnlineScaffold({super.key, this.header, required this.content});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding +
        const EdgeInsets.symmetric(horizontal: 25);

    return Material(
      color: OnlineTheme.background,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/header.svg',
                  height: 36,
                  fit: BoxFit.fitHeight,
                ),
                if (header != null) header!,
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                    stops: [
                      0.0,
                      0.05,
                    ],
                  ).createShader(bounds);
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      content,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
