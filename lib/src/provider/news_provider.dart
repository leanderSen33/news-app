import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/api_response.dart';
import '../model/article.dart';

class MissingApiKeyException implements Exception {}

class ApiKeyInvalidException implements Exception {}

class NewsProvider {
  static const String _apiKey = '9bf74f127ca645579d9be12bb215e7e3';

  static const String _baseURL = 'newsapi.org';
  static const String _topHeadLines = 'v2/everything';

  final http.Client _httpClient;

  NewsProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Article>> topHeadlines(String country) async {
    final result = await _callGetApi(
      endpoint: _topHeadLines,
      params: {
        'country': country,
        'apiKey': _apiKey,
      },
    );
    return result.articles!;
  }

  Future<ApiResponse> _callGetApi({
    required String endpoint,
    required Map<String, String> params,
  }) async {
    var uri = Uri.https(_baseURL, endpoint, params);

    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if (result.status == 'error') {
      if (result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if (result.code == 'apiKeyInvalidException')
        throw ApiKeyInvalidException();
      throw Exception();
    }
    return result;
  }
}
