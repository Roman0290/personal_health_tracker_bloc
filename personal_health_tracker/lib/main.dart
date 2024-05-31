import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_health_tracker/presention/screens/home/bloc/home_bloc.dart';
import 'package:personal_health_tracker/routes/app_router.dart';

void main() {
  
  runApp(BlocProvider(create:(context)=> HomeBloc(),child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Personal Health Tracker',
    );
  }
}