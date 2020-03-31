import 'package:covid_rest_api/app/services/api.dart';
import 'package:covid_rest_api/app/services/api_service.dart';
import 'package:covid_rest_api/app/ui/endpoint_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:covid_rest_api/app/repositories/data_repository.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cases;

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(EndPoint.cases);
    setState(() => _cases = cases);
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            EndpointCard(
              endpoint: EndPoint.cases,
              value: _cases,
            ),
          ],
        ),
      ),
    );
  }
}
