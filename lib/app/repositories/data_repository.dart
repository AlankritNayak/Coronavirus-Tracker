import 'package:covid_rest_api/app/repositories/endPointsData.dart';
import 'package:covid_rest_api/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:covid_rest_api/app/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;
  String _accessToken;


  Future<int> getEndpointData(EndPoint endPoint) async {
     return await _getEndpointsDataRefreshingToken(onGetData: ()=>apiService.getEndpointData(accessToken: _accessToken, endPoint: endPoint));
  }

  Future<EndpointsData> getAllEndpointData() async {
    return await _getEndpointsDataRefreshingToken(onGetData: _getAllEndpointData);
  }

  Future<T> _getEndpointsDataRefreshingToken<T>({@required Future<T> onGetData()}) async {
     try {
      if (_accessToken == null) {
         _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.confirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.recovered),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.suspected),
    ]);
    return EndpointsData(values: {
      EndPoint.cases: values[0],
      EndPoint.confirmed: values[1],
      EndPoint.deaths: values[2],
      EndPoint.recovered: values[3],
      EndPoint.suspected: values[4],
    });
  }
}
