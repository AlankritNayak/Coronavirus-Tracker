import 'package:covid_rest_api/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum EndPoint{
  cases,
  suspected,
  confirmed,
  deaths,
  recovered
}

class API{
  API({@required this.apiKey});
  final String apiKey;
  factory API.sandbox() => API(apiKey:  APIKeys.ncovSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi/1.0.0';

  Map<EndPoint, String> _paths ={
      EndPoint.cases: 'cases',
      EndPoint.confirmed: 'cases/confirmed',
      EndPoint.suspected: 'cases/suspected',
      EndPoint.deaths: 'deaths',
      EndPoint.recovered: 'recovered'
  };

  Uri tokenUri() => Uri(
    scheme: 'https',
    host: host,
    port: port,
    path: 'token',
    queryParameters: {'grant_type': 'client_credentials'},
  );

  Uri endpointUri(EndPoint endPoint) => Uri(
    scheme: 'https',
    port: port,
    host: host,
    path: '$basePath/${_paths[endPoint]}'
  );
}