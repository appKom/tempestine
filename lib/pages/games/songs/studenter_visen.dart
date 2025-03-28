import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/components/online_scaffold.dart';
import '/theme/theme.dart';

class StudenterVisenPage extends ScrollablePage {
  const StudenterVisenPage({super.key});

  String _getText() {
    return '''
Studenterliv er hundeliv - et skjødehundliv  
vov-vov-vov-vov-vov  
Det er et stadig driv, et fritidsfordriv,  
vi trenger penger,  
drikkepenger, senger - dobbeltsenger,  
så vi kan få all den kjærlighet vi trenger -  
så vi kan sove mye lenger

I med- og motgang gjør vi som studenter jo bør,  
vov-vov-vov-vov-vov  
da tar vi tilflukt i vårt gode humør,  
da tar vi harpen vår på fange -  
slår an de gamle klange  
og synger høyt sterkt og falsk studentersange -  
HØYT, STERKT OG FALSK STUDENTERSANGE

Her er det ærbar moro mellom samtlige kjønn  
vov-vov-vov-vov-vov  
med dans og pepsi og spillopper og gjøn  
og hvor det tilgis gjerne  
at de tråkkes litt på tærne,  

|: bare man mestrer de groveste begjær´ne :|

Studenterliv er hundeliv - et skjødehundliv  
vov-vov-vov-vov-vov  
Det er et stadig driv, et fritidsfordriv,  
men se, det spiller ingen trille -  
hva har vi å bestille?  

|: Nix, uten pilsner på Pernille :|
''';
  }

  @override
  Widget content(BuildContext context) {
    final padding = MediaQuery.of(context).padding + OnlineTheme.horizontalPadding;

    return Padding(
      padding: padding + const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Studenter Visen',
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
                border: Border(top: BorderSide(width: 1, color: OnlineTheme.current.border)),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
