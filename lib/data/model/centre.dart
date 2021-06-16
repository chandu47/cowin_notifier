import 'dart:convert';

import 'package:cowin_notifier/data/model/session.dart';
import 'package:equatable/equatable.dart';

class Center extends Equatable{

  final int center_id;
  final String name;
  final String address;
  final String state_name;
  final String district_name;
  final String block_name;
  final String pincode;
  final double lat;
  final double long;
  final String from;
  final String to;
  final String fee_type;
  final List<Session> sessions;

  factory Center.fromRawJson(String rawJson) => Center.fromJson(json.decode(rawJson));
  factory Center.fromJson(Map<String, dynamic> mp) => Center( mp["center_id"], mp["name"], mp["address"], mp["state_name"], mp["district_name"], mp["block_name"],
      mp["pincode"], mp["lat"], mp["long"], mp["from"], mp["to"], mp["fee_type"], mp["sessions"]);

  static List<Center> decode(String centers) =>
      ((json.decode(centers))['centers'] as List<dynamic>)
          .map<Center>((state) => Center.fromJson(state))
          .toList();

  Center(
      this.center_id,
      this.name,
      this.address,
      this.state_name,
      this.district_name,
      this.block_name,
      this.pincode,
      this.lat,
      this.long,
      this.from,
      this.to,
      this.fee_type,
      this.sessions);

  @override
  List<Object> get props => [center_id, name, address, state_name, district_name, block_name, pincode, lat, long, from, to, fee_type, sessions];
}