import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/paciente.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class DiarioService {
  static Future<List<Diario>> getDiarios() async {
    var url = "http://192.168.0.107/projetoapi/diario/lista";

    final token = await Prefs.getString("token");
    print("Tokenaaaaaaaaa > $token");
    final login = await Prefs.getString("login");
    print("Loginaaaaaa > $login");
    final response = await http.post(url, body: {
      "email": login,
      "token": token,
      "perfil": "pa"
    });

    final s = response.body;
//    print("diarios > $s");
    final mapDiario = json.decode(s).cast<Map<String, dynamic>>();

    final diario = mapDiario.map<Diario>((json) => Diario.fromJson(json)).toList();

    return diario;
  }

}
