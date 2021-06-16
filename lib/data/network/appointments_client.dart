import 'package:cowin_notifier/utils/request_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'connection_props.dart';

class AppointmentsClient{
  final Client _client;
  final String _host = ConnProps.host;
  final String _calendarByDistrictsEndpoint = ConnProps.calendarByDistrictEndpoint;
  final String _calendarByPincode = ConnProps.calendarByPincodeEndpoint;

  AppointmentsClient(this._client);

  Future<Response> request({@required RequestType, int district, String pincode, String date}){

  }
}