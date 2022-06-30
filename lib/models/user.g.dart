// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      notificationSettings: json['notificationSettings'] == null
          ? null
          : NotifSettings.fromJson(
              json['notificationSettings'] as Map<String, dynamic>),
      gardens: (json['gardens'] as List<dynamic>?)
          ?.map((e) => Garden.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'notificationSettings': instance.notificationSettings,
      'gardens': instance.gardens,
    };

NotifSettings _$NotifSettingsFromJson(Map<String, dynamic> json) =>
    NotifSettings(
      sendNotificationsAll: json['sendNotificationsAll'] as bool,
      sendNotificationsDeviceConnection:
          json['sendNotificationsDeviceConnection'] as bool,
      whenDeviceGoesOnline: json['whenDeviceGoesOnline'] as bool,
      whenDeviceGoesOffline: json['whenDeviceGoesOffline'] as bool,
      sendNotificationsSensors: json['sendNotificationsSensors'] as bool,
      sendNotificationsTemp: json['sendNotificationsTemp'] as bool,
      tempThresholdMax: (json['tempThresholdMax'] as num).toDouble(),
      tempThresholdMin: (json['tempThresholdMin'] as num).toDouble(),
      sendNotificationsHumidity: json['sendNotificationsHumidity'] as bool,
      humidityThresholdMax: (json['humidityThresholdMax'] as num).toDouble(),
      humidityThresholdMin: (json['humidityThresholdMin'] as num).toDouble(),
      sendNotificationsLightInt: json['sendNotificationsLightInt'] as bool,
      lightThresholdMax: (json['lightThresholdMax'] as num).toDouble(),
      lightThresholdMin: (json['lightThresholdMin'] as num).toDouble(),
      sendNotificationsSolar: json['sendNotificationsSolar'] as bool,
      solarThresholdMax: (json['solarThresholdMax'] as num).toDouble(),
      solarThresholdMin: (json['solarThresholdMin'] as num).toDouble(),
    );

Map<String, dynamic> _$NotifSettingsToJson(NotifSettings instance) =>
    <String, dynamic>{
      'sendNotificationsAll': instance.sendNotificationsAll,
      'sendNotificationsDeviceConnection':
          instance.sendNotificationsDeviceConnection,
      'whenDeviceGoesOnline': instance.whenDeviceGoesOnline,
      'whenDeviceGoesOffline': instance.whenDeviceGoesOffline,
      'sendNotificationsSensors': instance.sendNotificationsSensors,
      'sendNotificationsTemp': instance.sendNotificationsTemp,
      'tempThresholdMax': instance.tempThresholdMax,
      'tempThresholdMin': instance.tempThresholdMin,
      'sendNotificationsHumidity': instance.sendNotificationsHumidity,
      'humidityThresholdMax': instance.humidityThresholdMax,
      'humidityThresholdMin': instance.humidityThresholdMin,
      'sendNotificationsLightInt': instance.sendNotificationsLightInt,
      'lightThresholdMax': instance.lightThresholdMax,
      'lightThresholdMin': instance.lightThresholdMin,
      'sendNotificationsSolar': instance.sendNotificationsSolar,
      'solarThresholdMax': instance.solarThresholdMax,
      'solarThresholdMin': instance.solarThresholdMin,
    };
