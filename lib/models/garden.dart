import 'package:arduino_garden/models/schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'garden.g.dart';

@JsonSerializable()
class Garden {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final bool pump;
  final bool lights;
  @JsonKey(name: 'RGB')
  final RGB rgb;
  final double temperature;
  final int humidity;
  final int lightIntensity;
  final double solarVoltage;
  final double batteryVoltage;
  late final Schedule? schedule;
  final String gardenToken;
  final DateTime lastOnline;
  final DateTime? lastSaved;

  Garden({
    required this.id,
    required this.name,
    required this.pump,
    required this.lights,
    required this.rgb,
    required this.temperature,
    required this.humidity,
    required this.lightIntensity,
    required this.solarVoltage,
    required this.batteryVoltage,
    this.schedule,
    required this.gardenToken,
    required this.lastOnline,
    this.lastSaved,
  });

  factory Garden.fromJson(Map<String, dynamic> json) => _$GardenFromJson(json);

  Map<String, dynamic> toJson() => _$GardenToJson(this);

  @override
  String toString() {
    return 'Garden($id, $name, $pump, $lights, $rgb, $temperature, $humidity, $lightIntensity, $solarVoltage, $batteryVoltage,  $gardenToken, $lastOnline, $lastSaved)';
  }
}

@JsonSerializable(explicitToJson: true)
class RGB {
  final bool power;
  final int mode;
  final String color;

  RGB({
    required this.power,
    required this.mode,
    required this.color,
  });

  factory RGB.fromJson(Map<String, dynamic> json) => _$RGBFromJson(json);
  Map<String, dynamic> toJson() => _$RGBToJson(this);
}
