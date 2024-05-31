import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/presention/screens/auth/admin_log.dart';
import 'package:personal_health_tracker/presention/screens/auth/login_page.dart';
import 'package:personal_health_tracker/presention/screens/auth/signup_page.dart';
import 'package:personal_health_tracker/presention/screens/home/data_table.dart';
import 'package:personal_health_tracker/presention/screens/home/home_page.dart';
import 'package:personal_health_tracker/presention/screens/home/progress_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/admin-login',
      builder: (context, state) => AdminLogPage(),
    ),
    GoRoute(
      path: '/data-table',
      builder: (context, state) => const DataTablePage(),
    ),
    GoRoute(
      path: '/progress-chart',
      builder: (context, state) => HealthTrackerPage.withSampleData(),
    ),
  ],
);
