import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/presention/screens/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  final TextEditingController foodTypeController = TextEditingController();
  final TextEditingController caloriesAmountController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController waterIntakeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    foodTypeController.dispose();
    caloriesAmountController.dispose();
    weightController.dispose();
    heightController.dispose();
    exerciseController.dispose();
    waterIntakeController.dispose();
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToDataTablePageActionState) {
          context.go('/data-table');
        } else if (state is HomeNavigateToProgressChartPageActionState) {
          context.go('/progress-chart');
        } else if (state is HomeHealthDataSubmittedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Health data submitted successfully')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ጎመን በጤና'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    'Welcome to Your Health Tracker',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Input health data',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: foodTypeController,
                              decoration: const InputDecoration(
                                labelText: 'Calories Amount',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter calories amount';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: caloriesAmountController,
                              decoration: const InputDecoration(
                                labelText: 'Food Type',
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter food type';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: weightController,
                              decoration: const InputDecoration(
                                labelText: 'Weight',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter weight';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: heightController,
                              decoration: const InputDecoration(
                                labelText: 'Height',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter height';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: exerciseController,
                              decoration: const InputDecoration(
                                labelText: 'Minutes of Exercise',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter minutes of exercise';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: waterIntakeController,
                              decoration: const InputDecoration(
                                labelText: 'Amount of Water Taken (in liters)',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter water intake';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                homeBloc.add(HomeSubmitButtonClicked(
                                  foodType: foodTypeController.text,
                                  caloriesAmount: int.parse(caloriesAmountController.text),
                                  weight: double.parse(weightController.text),
                                  height: double.parse(heightController.text),
                                  minutesOfExercise: int.parse(exerciseController.text),
                                  waterIntake: double.parse(waterIntakeController.text),
                                ));
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      homeBloc.add(ViewDataTableRequested(context));
                    },
                    child: const Text('View Data Table'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      homeBloc.add(ViewProgressChartRequested(context));
                    },
                    child: const Text('View Progress Chart'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
