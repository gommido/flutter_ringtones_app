part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class GetStoragePermissionStatusState extends HomeState {}

class RequestStoragePermissionState extends HomeState {}

class OnWriteSettingsState extends HomeState {}
