import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;

  HttpClient(this.baseUrl);

  post(
      {required String endpoint,
      required dynamic data,
      required Map<String, String> headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        final responseData = response;
        return responseData;
      } else {
        throw Exception('HTTP POST Request Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('HTTP GET Request Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }
}
