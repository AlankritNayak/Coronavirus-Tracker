import 'package:covid_rest_api/app/repositories/data_repository.dart';
import 'package:covid_rest_api/app/services/api_service.dart';
import 'package:covid_rest_api/app/services/api.dart';
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
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final APIService _apiService = APIService(API.sandbox());
  String _accessToken = '';
  int _cases = 0;
  int _deaths = 0;
  Future<void> _updateAccessToken() async {
    final accessToken = await _apiService.getAccessToken();
      _accessToken = accessToken;
  }

  void _deathsandcases() async {
    await _updateAccessToken();
    print(_accessToken);
    _cases = await _apiService.getEndpointData(accessToken: _accessToken, endPoint: EndPoint.cases);
    _deaths = await _apiService.getEndpointData(accessToken: _accessToken, endPoint: EndPoint.deaths);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'deaths: $_deaths\n cases: $_cases',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _deathsandcases,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
