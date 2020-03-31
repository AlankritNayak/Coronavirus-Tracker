import 'package:covid_rest_api/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:covid_rest_api/app/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;
  String _accessToken;
  Future<int> getEndpointData(EndPoint endPoint) async {
    try {
      if (_accessToken == null) {
        final accessToken = await apiService.getAccessToken();
        _accessToken = accessToken;
      }
      return await apiService.getEndpointData(
          accessToken: _accessToken, endPoint: endPoint);
    } on Response catch (response) {
      if(response.statusCode == 401){
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(accessToken: _accessToken, endPoint: endPoint);
      }
      rethrow;
    }
  }
}
