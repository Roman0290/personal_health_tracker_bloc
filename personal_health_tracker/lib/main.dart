import 'package:flutter/material.dart';
import 'package:personal_health_tracker/routes/app_router.dart';

void main() {
  runApp(MyApp());
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