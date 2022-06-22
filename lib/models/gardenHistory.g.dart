// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gardenHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GardenHistory _$GardenHistoryFromJson(Map<String, dynamic> json) =>
    GardenHistory(
      gardenId: json['_id'] as String,
      dateAndTime: json['dateAndTime'] as DateTime,
      gardenData: json['gardenData'] as Garden,
    );

Map<String, dynamic> _$GardenHistoryToJson(GardenHistory instance) =>
    <String, dynamic>{
      '_id': instance.gardenId,
      'dateAndTime': instance.dateAndTime,
      'gardenData': instance.gardenData,
    };
