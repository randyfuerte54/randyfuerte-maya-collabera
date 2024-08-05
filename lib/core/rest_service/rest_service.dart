import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:randy_fuerte_technical_assessment/core/config/url_constants.dart';

class RestService {
  static final RestService _instance = RestService._internal();

  factory RestService() {
    return _instance;
  }

  RestService._internal();

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
    };
    return headers;
  }

  Future<http.Response> post(
    String url, {
    Object? body,
  }) async {
    Map<String, String>? authHeaders = await _getHeaders();

    final response = await http.post(
      Uri.parse(UrlConstants.apiUrl + url),
      headers: authHeaders,
      body: body,
    );
    return response;
  }
}
