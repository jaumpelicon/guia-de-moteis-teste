import '../setup/api_provider.dart';
import '../setup/endpoint.dart';

abstract class MotelsRepositoryProtocol {
  void getMotels({Success? success, Failure? failure});
}

class MotelsRepository extends MotelsRepositoryProtocol {
  final ApiProvider _provider = ApiProvider();

  @override
  void getMotels({Success? success, Failure? failure}) {
    final endpoint = Endpoint(
      method: 'GET',
      path: '/1IXK',
    );

    _provider.request(endpoint: endpoint, success: success, failure: failure);
  }
}
