import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../config/localization/localize.dart';
import '../../domain/errors/failure_error.dart';
import '../../domain/errors/unexpected_error.dart';
import '../../utils/service_locator/service_locator.dart';
import 'endpoint.dart';

abstract class ApiClientProtocol {
  Future<Either<FailureError, dynamic>> request({required Endpoint endpoint});
}

class ApiClient extends ApiClientProtocol {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<Either<FailureError, dynamic>> request({required Endpoint endpoint}) async {
    final l10n = ServiceLocator.get<LocalizeProtocol>().l10n;

    final contentTypeValue = endpoint.contentType ?? ContentType.json.value;

    final headers = {
      'Content-Type': contentTypeValue,
    };

    try {
      final uri = Uri.parse('${'https://www.jsonkeeper.com/b/'}${endpoint.path}');

      http.Response response;
      response = switch (endpoint.method) {
        'GET' => await _client.get(uri, headers: headers),
        'POST' => await _client.post(uri, headers: headers, body: json.encode(endpoint.data)),
        'PUT' => await _client.put(uri, headers: headers, body: json.encode(endpoint.data)),
        'DELETE' => await _client.delete(uri, headers: headers),
        _ => throw Exception(l10n.httpErrorMessage(endpoint.method)),
      };

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = utf8.decode(response.bodyBytes);
        return Right(json.decode(responseData));
      } else {
        return Left(
          UnexpectedError(
            code: response.statusCode.toString(),
            errorMessage: l10n.defaultErrorMessage,
          ),
        );
      }
    } on Exception catch (error) {
      return Left(
        UnexpectedError(
          errorMessage: l10n.defaultErrorMessage,
          nestedException: error,
        ),
      );
    }
  }
}
