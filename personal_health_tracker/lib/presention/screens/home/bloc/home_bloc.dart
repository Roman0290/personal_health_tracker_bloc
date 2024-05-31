import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:personal_health_tracker/local_storage/secure_storage.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeSubmitButtonClicked>(_onHealthDataSubmitted);
    on<ViewDataTableRequested>(_onViewDataTableRequested);
    on<ViewProgressChartRequested>(_onViewProgressChartRequested);
    on<FetchDataTable>(_fetchDataTable);
  }

  Future<void> _onHealthDataSubmitted(HomeSubmitButtonClicked event, Emitter<HomeState> emit) async {
    final token = await SecureStorage().secureStorage.read(key: 'token');
    print(token);
    final body = {
      "caloriesAmount": event.caloriesAmount,
      "foodType": event.foodType,
      "weight": event.weight,
      "height": event.height,
      "minutesOfExercise": event.minutesOfExercise,
      "waterIntake": event.waterIntake,
    };
    final jsonBody = jsonEncode(body);

    final url = Uri.parse('http://localhost:3000/health-records/createRecord'); 
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    };

    try {
      final res = await http.post(url, body: jsonBody, headers: headers);
      print(res.statusCode);
      if (res.statusCode == 201) {
        
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

  FutureOr<void> _fetchDataTable(FetchDataTable event, Emitter<HomeState> emit)async {
  
   final token = await SecureStorage().secureStorage.read(key: 'token');

    final url = Uri.parse('http://localhost:3000/health-records/findall'); 
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
  };


  final res = await http.get(url,headers: headers);
    

    final response = jsonDecode(res.body);
    print(response);
    emit(DataFetchSuccessState(data: response));
  

 



  }
}
