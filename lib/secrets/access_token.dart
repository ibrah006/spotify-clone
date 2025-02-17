import 'dart:convert';
import 'package:http/http.dart' as http;

class AccessToken {
  static String clientId = "f6405cbdcff44e999cc7f4d259ebf6cf",
      clientSecret = "d19ef58e2ebe459fa2a5331800042cf5";

  static String? lastAccessToken;

  static Future<String> getAccessToken() async {
    final url = Uri.parse('https://accounts.spotify.com/api/token');

    // Base64 encode the client_id:client_secret
    String credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic $credentials',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      // Parse the access token from the response
      final data = jsonDecode(response.body);

      lastAccessToken = data['access_token'];
      return lastAccessToken!;
    } else {
      throw Exception('Failed to get access token');
    }
  }
}
