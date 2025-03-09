import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';

import '/theme/theme.dart';

class DrikkeSanger extends StatelessWidget {
  const DrikkeSanger({super.key});

  @override
  Widget build(BuildContext context) {
    // List of songs with their routes
    final songs = [
      {'name': 'Lambo', 'route': '/social/lambo'},
      {'name': 'Fader Abraham', 'route': '/social/fader_abraham'},
      {'name': 'We like to drink with', 'route': '/social/we_like_to_drink'},
      {'name': 'Nu Klinger', 'route': '/social/nu_klinger'},
      {'name': 'Studenter Visen', 'route': '/social/studenter_visen'},
      {'name': 'Kamerater Hev Nu Glasset!', 'route': '/social/kamerater_hev_glasset'},
      {'name': 'Himmelseng', 'route': '/social/himmelseng'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Sanger',
          style: OnlineTheme.header(),
        ),
        SizedBox(height: 16),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: songs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: OnlineTheme.current.border,
          ),
          itemBuilder: (context, index) {
            return SongListItem(
              name: songs[index]['name']!,
              onTap: () => context.go(songs[index]['route']!),
            );
          },
        )
      ],
    );
  }
}

class SongListItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const SongListItem({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 32 + 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: OnlineTheme.current.fg,
                fontSize: 16,
              ),
            ),
            Icon(
              LucideIcons.chevron_right,
              color: OnlineTheme.current.mutedForeground,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
