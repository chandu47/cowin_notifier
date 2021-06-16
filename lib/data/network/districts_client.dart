
import 'package:cowin_notifier/data/network/connection_props.dart';
import 'package:cowin_notifier/utils/request_type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DistrictsClient{

  final Client _client;
  final String _host = ConnProps.host;
  final String _districtsEndpoint = ConnProps.districtsEndpoint;

  DistrictsClient(this._client);

  Future<Response> request({@required RequestType requestType, dynamic param}) async {
      switch(requestType){
        case RequestType.GET:
          return _client.get("$_host/$_districtsEndpoint/$param", headers: {"Content-Type": "application/json"});
      }
  }
}