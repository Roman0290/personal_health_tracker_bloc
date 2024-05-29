import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_health_tracker/presention/screens/home/bloc/home_bloc.dart';
import 'package:personal_health_tracker/presention/screens/home/data_table.dart';
import 'package:personal_health_tracker/presention/screens/home/progress_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,

      listenWhen: (previous, current) => current is HomeActionState,

      buildWhen: (previous, current) => current is! HomeActionState,

      listener: (context, state) {
        // TODO: implement listener
        // if(state is HomeHealthDataSubmitted){
        //   print("health data is submitted successfully");
        // }
        if (state is HomeNavigateToDataTablePageActionState){
          Navigator.push(
            ViewDataTableRequested(context).context,
            MaterialPageRoute(builder: (context) => DataTablePage()),
          );
        }
        else if(state is HomeNavigateToProgressChartPageActionState){
          Navigator.push(
            ViewProgressChartRequested(context).context,
            MaterialPageRoute(builder: (context) => HealthTrackerPage.withSampleData()),
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
                                // Submit button logic

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
                      homeBloc.add(ViewDataTableRequested(this.context));
                    },
                    child: const Text('View Data Table'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      homeBloc.add(ViewProgressChartRequested(this.context));
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
