part of 'home_bloc.dart';

@immutable
sealed class HomeState {}


abstract class HomeActionState extends HomeState{}


class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class HomeNavigateToDataTablePageActionState extends HomeActionState{}

class HomeNavigateToProgressChartPageActionState extends HomeActionState{}

