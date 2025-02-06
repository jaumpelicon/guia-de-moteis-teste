import 'package:dartz/dartz.dart';

import '../../domain/errors/failure_error.dart';
import '../../domain/errors/unexpected_error.dart';
import '../../domain/motels/motel_entity.dart';
import '../http/api_client.dart';
import '../http/endpoint.dart';

abstract class MotelsRepositoryProtocol {
  Future<Either<FailureError, List<MotelEntity>>> getMotels();
}

class MotelsRepository extends MotelsRepositoryProtocol {
  final ApiProvider _provider = ApiProvider();

  @override
  Future<Either<FailureError, List<MotelEntity>>> getMotels() async {
    final endpoint = Endpoint(
      method: 'GET',
      path: '/1IXK',
    );

    final response = await _provider.request(endpoint: endpoint);
    try {
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
