import 'package:cowin_notifier/utils/request_type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'connection_props.dart';

class StatesClient{
  final Client _client;
  final String _host = ConnProps.host;
  final String _statesEndPoint = ConnProps.statesEndpoint;
  StatesClient(this._client);

  Future<Response> request({@required RequestType requestType, dynamic param}) async {
    switch(requestType){
      case RequestType.GET:
        return _client.get("$_host/$_statesEndPoint", headers: {"Content-Type": "application/json"});
    }
  }
}