import 'package:arduino_garden/models/garden.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final NotifSettings? notifications;
  final List<Garden>? gardens;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.notifications,
    this.gardens,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User($id, $name, $email, $notifications, $gardens)';
  }
}

@JsonSerializable(explicitToJson: true)
class NotifSettings {
  final bool sendNotificationsAll;
  final bool sendNotificationsDeviceConnection;
  final bool whenDeviceGoesOnline;
  final bool whenDeviceGoesOffline;
  final bool sendNotificationsSensors;
  final bool sendNotificationsTemp;
  final double tempThresholdMax;
  final double tempThresholdMin;

  final bool sendNotificationsHumidity;
  final double humidityThresholdMax;
  final double humidityThresholdMin;

  final bool sendNotificationsLightInt;
  final double lightThresholdMax;
  final double lightThresholdMin;

  final bool sendNotificationsSolar;
  final double solarThresholdMax;
  final double solarThresholdMin;

  NotifSettings({
    required this.sendNotificationsAll,
    required this.sendNotificationsDeviceConnection,
    required this.whenDeviceGoesOnline,
    required this.whenDeviceGoesOffline,
    required this.sendNotificationsSensors,
    required this.sendNotificationsTemp,
    required this.tempThresholdMax,
    required this.tempThresholdMin,
    required this.sendNotificationsHumidity,
    required this.humidityThresholdMax,
    required this.humidityThresholdMin,
    required this.sendNotificationsLightInt,
    required this.lightThresholdMax,
    required this.lightThresholdMin,
    required this.sendNotificationsSolar,
    required this.solarThresholdMax,
    required this.solarThresholdMin,
  });

  factory NotifSettings.fromJson(Map<String, dynamic> json) =>
      _$NotifSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$NotifSettingsToJson(this);
}
