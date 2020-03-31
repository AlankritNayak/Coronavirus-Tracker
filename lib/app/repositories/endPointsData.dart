import 'package:covid_rest_api/app/services/api.dart';
import 'package:flutter/foundation.dart';



class EndpointsData{
  EndpointsData({this.values});
  final Map<EndPoint, int> values;
  
  int get cases => values[EndPoint.cases];
  int get suspected => values[EndPoint.suspected];
  int get deaths => values[EndPoint.deaths];
  int get recovered => values[EndPoint.recovered];
  int get confirmed => values[EndPoint.confirmed];

  @override
  String toString() {
    return 'cases: $cases, suspected: $suspected, deaths: $deaths, recovered: $recovered, confirmed: $confirmed';
  }
}