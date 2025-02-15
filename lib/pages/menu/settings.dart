import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/pages/menu/menu_page.dart';
import '/theme/theme.dart';
import '/theme/themed_icon.dart';
import '../event/cards/event_card.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  Map<String, bool> eventCategories = {
    'Bedriftspresentasjoner': false,
    'Kurs': false,
    'Sosialt': false,
    'Annet': false,
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var category in eventCategories.keys) {
        eventCategories[category] = (prefs.getBool(category) ?? eventCategories[category])!;
      }
    });
  }

  Future<void> _savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    eventCategories.forEach((category, subscribed) {
      prefs.setBool(category, subscribed);
    });
  }

  void _handleSubscription(String category, bool? subscribed) {
    setState(() {
      eventCategories[category] = subscribed!;
    });
    _savePreferences(); // Save preferences whenever a change is made

    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? topicName;
    if (category == 'Bedriftspresentasjoner') {
      topicName = '2';
    } else if (category == 'Kurs') {
      topicName = '3';
    } else if (category == 'Sosialt') {
      topicName = '1';
    } else {
      topicName = '4';
    }

    if (subscribed == true) {
      messaging.subscribeToTopic(topicName);
    } else if (subscribed == false) {
      messaging.unsubscribeFromTopic(topicName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnlineCard(
      padding: EdgeInsets.all(8),
      child: Foldout(
        leading: Padding(padding: EdgeInsets.only(right: 16), child: Lucide(LucideIcon.notification, size: 24)),
        title: 'Varslinger',
        headerPadding: EdgeInsets.all(16),
        contentPadding: EdgeInsets.only(left: 16, right: 6),
        open: true,
        children: eventCategories.keys.map(
          (String key) {
            return CheckboxListTile(
              title: Text(key, style: OnlineTheme.textStyle()),
              value: eventCategories[key],
              activeColor: OnlineTheme.current.pos,
              checkColor: OnlineTheme.current.fg,
              contentPadding: EdgeInsets.zero,
              onChanged: (bool? value) {
                _handleSubscription(key, value);
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
