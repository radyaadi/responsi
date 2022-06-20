import 'package:responsi/controller/baseNetwork.dart';
import 'package:responsi/model/weapModel.dart';
import 'package:responsi/model/charaModel.dart';

class DataSource {
  static DataSource instance = DataSource();

  //request for weapon detail
  Future<Map<String, dynamic>> loadWeapon(name) {
    return BaseNetwork.get("weapons/${name}");
  }

  //request for weapon detail
  Future<Map<String, dynamic>> loadChara(name) {
    return BaseNetwork.get("characters/${name}");
  }
}