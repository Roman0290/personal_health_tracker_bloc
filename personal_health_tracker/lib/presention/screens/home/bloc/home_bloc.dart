import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeSubmitButtonClicked>(_onHealthDataSubmitted);
    on<ViewDataTableRequested>(_onViewDataTableRequested);
    on<ViewProgressChartRequested>(_onViewProgressChartRequested);
  }

  Future<void> _onHealthDataSubmitted(HomeSubmitButtonClicked event, Emitter<HomeState> emit) async {
    final body = {
      "caloriesAmount": event.caloriesAmount,
      "foodType": event.foodType,
      "weight": event.weight,
      "height": event.height,
      "minutesOfExercise": event.minutesOfExercise,
      "waterIntake": event.waterIntake,
    };
    final jsonBody = jsonEncode(body);

    final url = Uri.parse('http://localhost:3000/');  // Make sure the URL is correct
    final headers = {
      "Content-Type": "application/json",
    };

    try {
      final res = await http.post(url, body: jsonBody, headers: headers);

      if (res.statusCode == 200) {
        emit(HomeHealthDataSubmittedState());
      } else {
        emit(HomeSubmitFailurestate());
      }
    } catch (e) {
      emit(HomeSubmitFailurestate());
    }
  }

  void _onViewDataTableRequested(ViewDataTableRequested event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDataTablePageActionState());
  }

  void _onViewProgressChartRequested(ViewProgressChartRequested event, Emitter<HomeState> emit) {
    emit(HomeNavigateToProgressChartPageActionState());
  }
}
