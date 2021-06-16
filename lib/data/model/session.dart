import 'package:equatable/equatable.dart';

class Session extends Equatable{

  final String session_id;
  final String date;
  final int available_capacity;
  final int min_age_limit;
  final String vaccine;
  final List<String> slots;
  final int available_capacity_dose1;
  final int available_capacity_dose2;


  Session(
      this.session_id,
      this.date,
      this.available_capacity,
      this.min_age_limit,
      this.vaccine,
      this.slots,
      this.available_capacity_dose1,
      this.available_capacity_dose2);
  
  
  factory Session.fromJson(Map<String, dynamic> mp) => Session(mp["session_id"], mp["date"], mp["available_capacity"], mp["min_age_limit"], mp["vaccine"], (mp["slots"] as List<dynamic>).map((st) => st).toList(),
      mp["available_capacity_dose1"], mp["available_capacity_dose2"]);

  static List<Session> decode(List<dynamic> sessions) =>
      sessions.map((sess) => Session.fromJson(sess)).toList();
  
  @override
  List<Object> get props => [session_id, date, available_capacity, min_age_limit, vaccine, slots, available_capacity_dose1, available_capacity_dose2];

}