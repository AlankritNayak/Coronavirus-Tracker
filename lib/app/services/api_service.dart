import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:covid_rest_api/app/services/api.dart';

class APIService{
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async{
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if(accessToken != null){
        return accessToken;
      }
    }
    print('Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEndpointData({
    @required String accessToken,
    @required EndPoint endPoint,
  }) async{
    final Uri uri = api.endpointUri(endPoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'}
    );
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      if(data.isNotEmpty){
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endPoint];
        final int result  = endpointData[responseJsonKey];
        if(result != null){
          return result;
        }
      }
    }
    print('Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<EndPoint, String> _responseJsonKeys ={
    EndPoint.cases : 'cases',
    EndPoint.confirmed: 'data',
    EndPoint.deaths: 'data',
    EndPoint.recovered: 'data',
    EndPoint.suspected: 'data',
  };
}