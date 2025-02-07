import 'package:dartz/dartz.dart';

import '../../domain/errors/failure_error.dart';
import '../../domain/errors/unexpected_error.dart';
import '../../domain/motels/motel_entity.dart';
import '../../utils/service_locator/service_locator.dart';
import '../http/api_client.dart';
import '../http/endpoint.dart';

abstract class MotelsRepositoryProtocol {
  Future<Either<FailureError, List<MotelEntity>>> getMotels();
}

class MotelsRepository extends MotelsRepositoryProtocol {
  final client = ServiceLocator.get<ApiClientProtocol>();

  @override
  Future<Either<FailureError, List<MotelEntity>>> getMotels() async {
    final endpoint = Endpoint(
      method: 'GET',
      path: '/1IXK',
    );

    try {
      final response = await client.request(endpoint: endpoint);

      return response.fold(
        (error) => Left(error),
        (success) => Right(MotelEntity.fromMap(success)),
      );
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
