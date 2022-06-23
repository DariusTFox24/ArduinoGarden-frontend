// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gardenHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GardenHistory _$GardenHistoryFromJson(Map<String, dynamic> json) =>
    GardenHistory(
      gardenId: json['_id'] as String,
      dateAndTime: DateTime.parse(json['dateAndTime'] as String),
      gardenData: Garden.fromJson(json['gardenData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GardenHistoryToJson(GardenHistory instance) =>
    <String, dynamic>{
      '_id': instance.gardenId,
      'dateAndTime': instance.dateAndTime.toIso8601String(),
      'gardenData': instance.gardenData,
    };
