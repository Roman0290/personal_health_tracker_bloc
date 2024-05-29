part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeSubmitButtonClicked extends HomeEvent {
  final int caloriesAmount;
  final String foodType;
  final double weight;
  final double height;
  final int minutesOfExercise;
  final double waterIntake;

  HomeSubmitButtonClicked({
    required this.caloriesAmount,
    required this.foodType,
    required this.weight,
    required this.height,
    required this.minutesOfExercise,
    required this.waterIntake,
  });
}
class HomeSubmitFailure extends HomeEvent{}


class ViewDataTableRequested extends HomeEvent {
  final BuildContext context;

  ViewDataTableRequested(this.context);
}

class ViewProgressChartRequested extends HomeEvent {
  final BuildContext context;

  ViewProgressChartRequested(this.context);
}



