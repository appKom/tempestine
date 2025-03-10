import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/components/online_scaffold.dart';
import '/theme/theme.dart';

class FaderAbrahamPage extends ScrollablePage {
  const FaderAbrahamPage({super.key});

  String _getText() {
    return '''
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham! 
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm”\n
---
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham!\n
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm, venstre arm”\n
---
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham!\n
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm, venstre arm, høyre fot”\n
---
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham!\n
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm, venstre arm, høyre fot, venstre fot”\n
---
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham!\n
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm, venstre arm, høyre fot, venstre fot, rumpa ut”\n
---
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham!\n
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm, venstre arm, høyre fot, venstre fot, rumpa ut, kroppen frem”\n
---
Fader abraham har fire sønner, ja fire sønner, har Fader Abraham!\n
Også drakk de litt (drikk)\n
Også drakk de litt (drikk)\n
Og de moret seg og sang; “Høyre arm, venstre arm, høyre fot, venstre fot, rumpa ut, kroppen frem, tunga ut”\n
''';
  }

  @override
  Widget content(BuildContext context) {
    final padding = MediaQuery.of(context).padding + OnlineTheme.horizontalPadding;

    return Padding(
      padding: padding + EdgeInsets.symmetric(vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Fader Abraham',
            style: OnlineTheme.header(),
          ),
          const SizedBox(height: 24),
          MarkdownBody(
            data: _getText(),
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: OnlineTheme.textStyle(),
              h1: TextStyle(color: OnlineTheme.current.fg),
              h2: TextStyle(color: OnlineTheme.current.fg),
              h3: TextStyle(color: OnlineTheme.current.fg),
              h4: TextStyle(color: OnlineTheme.current.fg),
              h5: TextStyle(color: OnlineTheme.current.fg),
              h6: TextStyle(color: OnlineTheme.current.fg),
              horizontalRuleDecoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: OnlineTheme.current.border),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
