part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<MotelEntity> motels;
  HomeSuccess({required this.motels});

  @override
  List<Object?> get props => [motels];
}

final class HomeError extends HomeState {
  final FailureError error;
  HomeError({required this.error});

  @override
  List<Object?> get props => [error];
}
