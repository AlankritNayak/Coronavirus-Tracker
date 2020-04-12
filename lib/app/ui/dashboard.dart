import 'package:covid_rest_api/app/repositories/endPointsData.dart';
import 'package:covid_rest_api/app/services/api.dart';
import 'package:covid_rest_api/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:covid_rest_api/app/repositories/data_repository.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endPointData;

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endPointsData = await dataRepository.getAllEndpointData();
    setState(() => _endPointData = endPointsData);
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
            for(var endPoint in EndPoint.values)
            EndpointCard(
              endpoint: endPoint,
              value: _endPointData != null ? _endPointData.values[endPoint]: null,
            ),
          ],
        ),
      ),
    );
  }
}
