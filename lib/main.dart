import 'package:covid_rest_api/app/repositories/data_repository.dart';
import 'package:covid_rest_api/app/services/api_service.dart';
import 'package:covid_rest_api/app/services/api.dart';
import 'package:covid_rest_api/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
        create: (_) => DataRepository(apiService: APIService(API.sandbox())),
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(
        ).copyWith(
          scaffoldBackgroundColor: Color(0xff101010) ,
          cardColor: Color(0xff222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}

