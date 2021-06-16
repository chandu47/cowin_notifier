import 'package:equatable/equatable.dart';
import 'dart:convert';

//Model to represent the Districts from Cowin api
class District extends Equatable{

  final int district_id;
  final String district_name;


  District(this.district_id, this.district_name);

  factory District.fromRawJson(String rawJson) => District.fromJson(json.decode(rawJson));
  factory District.fromJson(Map<String, dynamic> json) => District(int.parse(json['district_id'].toString()), json['district_name']);

  static Map<String, dynamic> toJson(District district) => { 'district_id': district.district_id, 'district_name': district.district_name};

  static String encode(List<District> districts) => json.encode(
    districts
        .map<Map<String, dynamic>>((dis) => District.toJson(dis))
        .toList()
  );

  static List<District> decode(String districts) =>
      ((json.decode(districts))['districts'] as List<dynamic>)
        .map<District>((dis) => District.fromJson(dis))
        .toList();

  static List<District> decodeJson(dynamic districts) =>
      (districts as List<dynamic>)
          .map<District>((dis) => District.fromJson(dis))
          .toList();


  @override
  List<Object> get props => [district_id, district_name];
}