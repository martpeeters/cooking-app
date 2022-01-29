import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'Storable.dart';

class Database {
  List<Storable> data;
  String localPath = "";

  Database() {
    data = [];

    initiate();
  }

  Future<void> initiate() async {
    Directory dir = await getApplicationDocumentsDirectory();
    localPath = dir.path;
  }

  void subscribe(Storable d) {
    data.add(d);
  }

  void subscribeAll(List<Storable> ld) {
    for (Storable d in ld)
      data.add(d);
  }

  Future<void> save() async {
    for (Storable d in data) {
      Map<String, dynamic> content = d.saveObject();
      String encode = json.encode(content);
        File file = File(localPath + '/database/' + d.getName() + '.json');
        file.writeAsString(encode);
    }
  }

  Future<void> load() async {
    for (Storable d in data) {
      Map<String, dynamic> decode = jsonDecode(localPath + '/database/' + d.getName() + '.json');
      d.loadObject(decode);
    }
  }

  void reset() {
    for (Storable d in data)
      d.reset();
  }
}