import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  @JsonKey(name: '_id')
  final String id;
  final String timePump;
  final String timeLights;
  final String scheduleName;
  final String durationPump;
  final String durationLights;
  final WeekdaysPump weekdaysPump;
  final WeekdaysLight weekdaysLight;

  Schedule({
    required this.id,
    required this.timePump,
    required this.timeLights,
    required this.scheduleName,
    required this.durationPump,
    required this.durationLights,
    required this.weekdaysPump,
    required this.weekdaysLight,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  String toString() {
    return 'Schedule($id,)';
  }
}

@JsonSerializable(explicitToJson: true)
class WeekdaysPump {
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;

  WeekdaysPump({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory WeekdaysPump.fromJson(Map<String, dynamic> json) =>
      _$WeekdaysPumpFromJson(json);
  Map<String, dynamic> toJson() => _$WeekdaysPumpToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeekdaysLight {
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;

  WeekdaysLight({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory WeekdaysLight.fromJson(Map<String, dynamic> json) =>
      _$WeekdaysLightFromJson(json);
  Map<String, dynamic> toJson() => _$WeekdaysLightToJson(this);
}
