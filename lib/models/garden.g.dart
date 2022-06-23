// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Garden _$GardenFromJson(Map<String, dynamic> json) => Garden(
      id: json['_id'] as String,
      name: json['name'] as String,
      pump: json['pump'] as bool,
      lights: json['lights'] as bool,
      rgb: RGB.fromJson(json['RGB'] as Map<String, dynamic>),
      temperature: (json['temperature'] as num).toDouble(),
      humidity: json['humidity'] as int,
      lightIntensity: json['lightIntensity'] as int,
      solarVoltage: (json['solarVoltage'] as num).toDouble(),
      batteryVoltage: (json['batteryVoltage'] as num).toDouble(),
      schedule: json['schedule'] == null
          ? null
          : Schedule.fromJson(json['schedule'] as Map<String, dynamic>),
      gardenToken: json['gardenToken'] as String,
      lastOnline: DateTime.parse(json['lastOnline'] as String),
      lastSaved: json['lastSaved'] == null
          ? null
          : DateTime.parse(json['lastSaved'] as String),
    );

Map<String, dynamic> _$GardenToJson(Garden instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'pump': instance.pump,
      'lights': instance.lights,
      'RGB': instance.rgb,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'lightIntensity': instance.lightIntensity,
      'solarVoltage': instance.solarVoltage,
      'batteryVoltage': instance.batteryVoltage,
      'schedule': instance.schedule,
      'gardenToken': instance.gardenToken,
      'lastOnline': instance.lastOnline.toIso8601String(),
      'lastSaved': instance.lastSaved?.toIso8601String(),
    };

RGB _$RGBFromJson(Map<String, dynamic> json) => RGB(
      power: json['power'] as bool,
      mode: json['mode'] as int,
      color: json['color'] as String,
    );

Map<String, dynamic> _$RGBToJson(RGB instance) => <String, dynamic>{
      'power': instance.power,
      'mode': instance.mode,
      'color': instance.color,
    };
