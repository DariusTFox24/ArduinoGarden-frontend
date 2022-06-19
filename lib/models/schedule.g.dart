// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['_id'] as String,
      timePump: json['timePump'] as String,
      timeLights: json['timeLights'] as String,
      scheduleName: json['scheduleName'] as String,
      durationPump: json['durationPump'] as String,
      durationLights: json['durationLights'] as String,
      weekdaysPump:
          WeekdaysPump.fromJson(json['weekdaysPump'] as Map<String, dynamic>),
      weekdaysLight:
          WeekdaysLight.fromJson(json['weekdaysLight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      '_id': instance.id,
      'timePump': instance.timePump,
      'timeLights': instance.timeLights,
      'scheduleName': instance.scheduleName,
      'durationPump': instance.durationPump,
      'durationLights': instance.durationLights,
      'weekdaysPump': instance.weekdaysPump,
      'weekdaysLight': instance.weekdaysLight,
    };

WeekdaysPump _$WeekdaysPumpFromJson(Map<String, dynamic> json) => WeekdaysPump(
      monday: json['monday'] as bool,
      tuesday: json['tuesday'] as bool,
      wednesday: json['wednesday'] as bool,
      thursday: json['thursday'] as bool,
      friday: json['friday'] as bool,
      saturday: json['saturday'] as bool,
      sunday: json['sunday'] as bool,
    );

Map<String, dynamic> _$WeekdaysPumpToJson(WeekdaysPump instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };

WeekdaysLight _$WeekdaysLightFromJson(Map<String, dynamic> json) =>
    WeekdaysLight(
      monday: json['monday'] as bool,
      tuesday: json['tuesday'] as bool,
      wednesday: json['wednesday'] as bool,
      thursday: json['thursday'] as bool,
      friday: json['friday'] as bool,
      saturday: json['saturday'] as bool,
      sunday: json['sunday'] as bool,
    );

Map<String, dynamic> _$WeekdaysLightToJson(WeekdaysLight instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };
