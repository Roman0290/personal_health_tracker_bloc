import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/presention/screens/home/bloc/home_bloc.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({Key? key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  @override
  void initState() {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(FetchDataTable());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    print(homeBloc.state);
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen:(previous,current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print(state);
        if (state is DataFetchSuccessState){
        List data = state.data;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                GoRouter.of(context).go('/');
              },
            ),
            title: const Text('Data Table'),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    DataTable(
                      columnSpacing: 10.0, // Adjust the spacing between columns
                      columns: [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Calories')),
                        DataColumn(label: Text('Weight')),
                        DataColumn(label: Text('Height')),
                        DataColumn(label: Text('Food Type')),
                        DataColumn(label: Text('Minutes of Exercise')),
                        DataColumn(label: Container(width: 100.0)),
                      ],
                      rows: 
                  data.map((e) => 
                            DataRow(cells: [
                           DataCell(Text(e.containsKey("date") ?e["date"].toString().substring(0,10):"")),
                          DataCell(Text(e.containsKey("caloriesAmount")? e["caloriesAmount"].toString():"")),
                          DataCell(Text(e.containsKey("weight")? e["weight"].toString():"")),
                          DataCell(Text(e.containsKey("height") ?e["height"].toString():"")),
                          DataCell(Text(e.containsKey("foodType")? e["foodType"].toString():"")),
                          DataCell(Text (e.containsKey("minutesOfExercise")? e["minutesOfExercise"].toString():"")),
                          
                          DataCell(Container(width: 100.0)),
                        ]),).toList()
                        
                        
                        // Add more rows with data as needed
                      ,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
       
        }
         return Container();
      },
      
    );
  }
}
