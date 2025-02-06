import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../domain/errors/failure_error.dart';
import '../../domain/errors/unexpected_error.dart';
import 'api_host.dart';
import 'endpoint.dart';

class ApiProvider {
  final http.Client _client;

  ApiProvider({http.Client? client}) : _client = client ?? http.Client();

  Future<Either<FailureError, dynamic>> request({required Endpoint endpoint}) async {
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
        final responseData = utf8.decode(response.bodyBytes);
        return Right(json.decode(responseData));
      } else {
        return Left(
          UnexpectedError(
            code: response.statusCode.toString(),
            errorMessage: 'Falha na chamada',
          ),
        );
      }
    } on Exception catch (error) {
      return Left(
        UnexpectedError(
          errorMessage: 'Algo deu errado tente novamente',
          nestedException: error,
        ),
      );
    }
  }
}
