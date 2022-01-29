import '../../database/Assets.dart';

class Timer {

  String name;
  int duration; // minutes
  String temperature;
  String temperatureUnit;
  String ovenMode;

  Timer.fromJSON(Assets assets, Map<String, dynamic> json) {
    this.name = json['name'];
    this.duration = int.parse(json['duration'].replaceAll('PT', '').replaceAll('M',''));
    this.temperature = json['temperature'];
    this.temperatureUnit = json['temperatureUnit'];
    this.ovenMode = json['ovenMode'];
  }
}