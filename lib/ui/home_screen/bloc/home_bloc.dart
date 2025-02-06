import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositorys/motels_repository.dart';
import '../../../domain/errors/failure_error.dart';
import '../../../domain/motels/motel_entity.dart';
import '../../../utils/service_locator/service_locator.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = ServiceLocator.get<MotelsRepositoryProtocol>();

  HomeBloc() : super(HomeInitial()) {
    on<GetHomeMotelsEvent>(_getHomeMotels);
  }

  Future<void> _getHomeMotels(GetHomeMotelsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final response = await repository.getMotels();
    response.fold(
      (error) => emit(HomeError(error: error)),
      (success) => emit(HomeSuccess(motels: success)),
    );
  }
}
