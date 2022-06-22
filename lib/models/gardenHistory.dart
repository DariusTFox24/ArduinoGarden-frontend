import 'package:arduino_garden/models/garden.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gardenHistory.g.dart';

@JsonSerializable()
class GardenHistory {
  @JsonKey(name: '_id')
  final String gardenId;
  final DateTime dateAndTime;
  final Garden gardenData;

  GardenHistory({
    required this.gardenId,
    required this.dateAndTime,
    required this.gardenData,
  });

  factory GardenHistory.fromJson(Map<String, dynamic> json) =>
      _$GardenHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$GardenHistoryToJson(this);

  @override
  String toString() {
    return 'gardenHistory\n($gardenId,\n $dateAndTime,\n $gardenData\n)';
  }
}
