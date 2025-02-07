import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_motel_teste/data/http/api_client.dart';
import 'package:guia_de_motel_teste/data/repositorys/motels_repository.dart';
import 'package:guia_de_motel_teste/domain/errors/unexpected_error.dart';
import 'package:guia_de_motel_teste/domain/motels/motel_entity.dart';
import 'package:guia_de_motel_teste/utils/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks_json/motels_json_mock.dart';
import 'motels_repository_test.mocks.dart';

@GenerateMocks([ApiClient, MotelEntity])
void main() {
  final apiClient = MockApiClient();
  ServiceLocator.registerSingleton<ApiClientProtocol>(apiClient);

  final motelRepository = MotelsRepository();

  group('motels repository tests', () {
    test('test getMotels when succes request', () async {
      when(apiClient.request(endpoint: anyNamed('endpoint')))
          .thenAnswer((_) async => Right(jsonDecode(MotelsJsonMock.motelsJson)));

      final response = await motelRepository.getMotels();

      expect(response.isRight(), isTrue);
      expect(response.fold(id, id), isA<List<MotelEntity>>());
    });
    test('test getMotels when succes request and failure mapping', () async {
      when(apiClient.request(endpoint: anyNamed('endpoint')))
          .thenAnswer((_) async => Right(jsonDecode('{nome: "teste"}')));

      final response = await motelRepository.getMotels();

      expect(response.isLeft(), isTrue);
      expect(response.fold(id, id), isA<UnexpectedError>());
    });
    test('test getMotels when failure request', () async {
      final nestedException = Exception('Server error');
      final requestError = UnexpectedError(
        code: '500',
        errorMessage: 'Server error',
        nestedException: nestedException,
      );
      when(apiClient.request(endpoint: anyNamed('endpoint'))).thenAnswer((_) async => Left(requestError));

      final response = await motelRepository.getMotels();

      expect(response.isLeft(), isTrue);
      expect(response.fold(id, id), isA<UnexpectedError>());
      response.fold((error) {
        expect(error.message, 'Server error');
        expect(error.statusCode, '500');
        expect(error.stackTrace, nestedException);
      }, (_) {});
    });
  });
}
