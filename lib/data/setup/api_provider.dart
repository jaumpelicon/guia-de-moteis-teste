import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_host.dart';
import 'endpoint.dart';

typedef Failure = void Function(Exception error);
typedef Success = void Function(dynamic response);

class ApiProvider {
  final http.Client _client;

  ApiProvider({http.Client? client}) : _client = client ?? http.Client();

  Future<void> request({required Endpoint endpoint, Success? success, Failure? failure}) async {
    final contentTypeValue = endpoint.contentType ?? ContentType.json.value;

    final headers = {
      'Content-Type': contentTypeValue,
    };

    try {
      final uri = Uri.parse('${ApiHost.baseURL}${endpoint.path}');

      http.Response response;
      response = switch (endpoint.method) {
        'GET' => await _client.get(uri, headers: headers),
        'POST' => await _client.post(uri, headers: headers, body: json.encode(endpoint.data)),
        'PUT' => await _client.put(uri, headers: headers, body: json.encode(endpoint.data)),
        'DELETE' => await _client.delete(uri, headers: headers),
        _ => throw Exception('Unsupported HTTP method: ${endpoint.method}'),
      };

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        success?.call(responseData);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on Exception catch (error) {
      failure?.call(error);
    }
  }
}
