import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/config/localization/localize.dart';
import 'package:guia_de_motel_teste/data/http/api_client.dart';
import 'package:guia_de_motel_teste/data/http/endpoint.dart';
import 'package:guia_de_motel_teste/domain/errors/unexpected_error.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../config/localization/localize_mock.dart';
import 'api_client_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiClient apiClient;
  late MockClient mockClient;
  final mockLocalize = LocalizeMock.instance;
  ServiceLocator.registerSingleton<LocalizeProtocol>(mockLocalize);

  setUp(() {
    mockClient = MockClient();

    apiClient = ApiClient(client: mockClient);
  });
  group('apiClient', () {
    final endpoint = Endpoint(
      path: '/test',
      method: 'GET',
    );

    test('should return Right (success) when API call is successful', () async {
      final jsonResponse = jsonEncode({'message': 'success'});

      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(jsonResponse, 200));

      final result = await apiClient.request(endpoint: endpoint);

      expect(result, isA<Right>());
      expect((result as Right).value, {'message': 'success'});
    });

    test('should return Left (failure) when API returns error', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      final result = await apiClient.request(endpoint: endpoint);

      expect(result, isA<Left>());
      final failure = (result as Left).value;
      expect(failure, isA<UnexpectedError>());
      expect(failure.code, '401');
    });

    test('should return Left (failure) on network error', () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenThrow(Exception('Network error'));

      final result = await apiClient.request(endpoint: endpoint);

      expect(result, isA<Left>());
      final failure = (result as Left).value;
      expect(failure, isA<UnexpectedError>());
      expect(failure.errorMessage, mockLocalize.l10n.defaultErrorMessage);
    });

    test('should handle different HTTP methods correctly', () async {
      final jsonResponse = jsonEncode({'message': 'success'});
      when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
        (_) async {
          return http.Response(jsonResponse, 200);
        },
      );
      when(mockClient.delete(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
        (_) async {
          return http.Response(jsonResponse, 200);
        },
      );

      when(mockClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
        (_) async {
          return http.Response(jsonResponse, 200);
        },
      );

      for (final method in ['POST', 'PUT', 'DELETE']) {
        final endpoint = Endpoint(
          path: '/test',
          method: method,
          data: {'key': 'value'},
        );

        final result = await apiClient.request(endpoint: endpoint);

        expect(result, isA<Right>());
      }
    });

    test('should return Left on invalid HTTP method', () async {
      final invalidEndpoint = Endpoint(
        path: '/test',
        method: 'INVALID',
      );

      final result = await apiClient.request(endpoint: invalidEndpoint);

      expect(result, isA<Left>());
    });
  });
}
