import 'dart:convert';

import 'package:arduino_garden/models/garden.dart';
import 'package:arduino_garden/models/schedule.dart';
import 'package:arduino_garden/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/gardenHistory.dart';

class ArduinoGardenApi {
  final Uri host;
  const ArduinoGardenApi(this.host);

  Uri uriFor(String path) => host.replace(path: path);

  Future<String> register(String name, String email, String password) async {
    final payload = {
      "name": name,
      "email": email,
      "password": password,
    };
    final data = await http.post(
      uriFor('/api/auth/create'),
      body: json.encode(payload),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return result["message"];
  }

  Future<String> authenticate(String email, String password) async {
    final payload = {
      "email": email,
      "password": password,
    };
    final data = await http.post(
      uriFor('/api/auth'),
      body: json.encode(payload),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return result["message"];
  }

  Future<User> getOwnUser(String token) async {
    final data = await http.get(
      uriFor('/api/user'),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result['message']);
    }
    print(result['message']);
    return User.fromJson(result['message']);
  }

  Future<Garden> createGarden(String token, String name) async {
    final payload = {
      "name": name,
    };
    final data = await http.post(
      uriFor('/api/garden/createGarden'),
      body: json.encode(payload),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return Garden.fromJson(result['message']);
  }

  Future<dynamic> userUpdateData(
      String token, String gardenId, Object payload) async {
    final data = await http.post(
      uriFor('/api/garden/userUpdateData/' + gardenId),
      body: json.encode(payload),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return result['message'];
  }

  Future<void> deleteGarden(String token, String gardenId) async {
    final data = await http.delete(
      uriFor('/api/garden/deleteGarden/' + gardenId),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return result['message'];
  }

  Future<List<Schedule>> getSchedules(String token) async {
    final data = await http.get(
      uriFor('/api/schedule/getSchedules'),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result['message']);
    }
    return (result["message"] as List<dynamic>)
        .map((e) => Schedule.fromJson(e))
        .toList();
  }

  Future<Schedule> createSchedule(String token, Object payload) async {
    final data = await http.post(
      uriFor('/api/schedule/createSchedule'),
      body: json.encode(payload),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return Schedule.fromJson(result['message']);
  }

  Future<Schedule> setScheduleState(
      String token, String scheduleId, bool value) async {
    final data = await http.post(
      uriFor('/api/schedule/setActiveSchedule/' +
          scheduleId +
          '/' +
          value.toString()),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    return Schedule.fromJson(result['message']);
  }

  Future<void> updateGardenSchedule(
      String token, String gardenId, String scheduleId) async {
    final data = await http.get(
      uriFor('/api/garden/assignSchedule/' + gardenId + '/' + scheduleId),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result["message"]);
    }
    print(result);
  }

  Future<List<GardenHistory>> getGardenHistory(
      String token, String gardenId) async {
    final data = await http.get(
      uriFor('/api/garden/getGardenHistory/' + gardenId),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    if (result['error']) {
      throw Exception(result['message']);
    }
    return (result["message"] as List<dynamic>)
        .map((e) => GardenHistory.fromJson(e))
        .toList();
  }

  Future<GardenHistory> saveGardenHistoryData(
      String token, String gardenId) async {
    final data = await http.get(
      uriFor('/api/garden/saveGardenHistoryData/' + gardenId),
      headers: {
        "x-auth-token": token,
        "Content-Type": "application/json",
      },
    );
    final result = jsonDecode(data.body);
    print(result);
    if (result['error']) {
      throw Exception(result['message']);
    }
    return GardenHistory.fromJson(result["message"]);
  }
}
