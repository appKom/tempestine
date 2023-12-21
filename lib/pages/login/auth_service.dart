import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AuthService {
  static const String clientId = '972717'; 
  static const String redirectUri = 'https://cloud.appwrite.io/v1/account/sessions/oauth2/callback/oidc/65706141ead327e0436a'; // Replace with your Appwrite redirect URI

  static String get authorizationUrl =>
      'https://old.online.ntnu.no/openid/authorize?client_id=$clientId&redirect_uri=${Uri.encodeComponent(redirectUri)}&response_type=code&scope=openid+profile+onlineweb4+events';

  static Future<Map<String, dynamic>?> exchangeCodeForToken(String code) async {
    final response = await http.post(
      Uri.parse('https://old.online.ntnu.no/openid/token'), 
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_id': clientId,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error exchanging code for token: ${response.body}');
      return null;
    }
  }
}