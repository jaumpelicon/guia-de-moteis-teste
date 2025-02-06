part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<MotelEntity> motels;
  HomeSuccess({required this.motels});
}

final class HomeError extends HomeState {
  final FailureError error;
  HomeError({required this.error});
}
