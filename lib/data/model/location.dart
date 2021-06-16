import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable{

  int residenceState;
  int district;
  String pincode;


  Location(this.residenceState, this.district, this.pincode);

  @override
  List<Object> get props => [residenceState, district, pincode];

  factory Location.fromRawJson(String rawJson) => Location.fromJson(json.decode(rawJson));
  factory Location.fromJson(Map<String, dynamic> json) => Location(json['state'], json['district'], json['pincode']);

  Map<String, dynamic> toJson() => {"state": residenceState, "district": district, "pincode": pincode};

  String toRawJson() => json.encode(this.toJson());

}