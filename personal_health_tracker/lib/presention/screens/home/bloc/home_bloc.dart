import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
// import 'package:personal_health_tracker/presention/screens/home/data_table.dart';
// import 'package:personal_health_tracker/presention/screens/home/progress_page.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeSubmitButtonClicked>(_onHealthDataSubmitted);
    on<ViewDataTableRequested>(viewDataTableRequested);
    on<ViewProgressChartRequested>(viewProgressChartRequested);
  }

FutureOr<void> _onHealthDataSubmitted(HomeSubmitButtonClicked event, Emitter<HomeState> emit) {
  }
  FutureOr<void> viewDataTableRequested(ViewDataTableRequested event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDataTablePageActionState());
  }

  FutureOr<void> viewProgressChartRequested(ViewProgressChartRequested event, Emitter<HomeState> emit) {
    emit(HomeNavigateToProgressChartPageActionState());
  }

  
}