import 'package:cowin_notifier/data/model/district.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

//Model to represent the States from Cowin api
class States extends Equatable{
  final int state_id;
  final String state_name;

  List<District> districts;

  set districtsList(List<District> districts){
    districtsList = districts;
  }


  List<District> get districtsList => districtsList;

  States(this.state_id, this.state_name, {this.districts});

  static List<States> decode(String states) =>
      ((json.decode(states))['states'] as List<dynamic>)
        .map<States>((state) => States.fromJson(state))
        .toList();

  //encoding states list
  static String encode(List<States> states) => json.encode({
    'states': states
        .map<Map<String, dynamic>>((state) => States.toJson(state))
        .toList()
  });

  factory States.fromRawJson(String rawJson) => States.fromJson(json.decode(rawJson));
  factory States.fromJson(Map<String, dynamic> json){

    if(json['districts'] !=null)
      return States( int.parse(json['state_id'].toString()), json['state_name'], districts: District.decodeJson(json['districts']));
    else
      return States( int.parse(json['state_id'].toString()), json['state_name']);
  }

  //change district to json while converting state to json
  static Map<String, dynamic> toJson(States state) => {
    'state_id': state.state_id,
    'state_name': state.state_name,
    'districts': state.districts
                      .map<Map<String, dynamic>>((dis) => District.toJson(dis))
                      .toList()
  };

  @override
  List<Object> get props => [this.state_id, this.state_name];

}