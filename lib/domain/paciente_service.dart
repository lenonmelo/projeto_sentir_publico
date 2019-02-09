import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/paciente.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class PacienteService {
  static Future<List<Paciente>> getPacientes() async {
    var url = "http://192.168.0.107/projetoapi/diario/listapacientes";

    final token = await Prefs.getString("token");
    print("Token > $token");

    final login = await Prefs.getString("login");
    print("Login > $login");

    final response = await http.post(url, body: {
      "email": login,
      "token": token,
      "perfil": "ps"
    });

    final s = response.body;
    print(s);

    final mapPacientes = json.decode(s).cast<Map<String, dynamic>>();

    final carros = mapPacientes.map<Paciente>((json) => Paciente.fromJson(json)).toList();

    return carros;
  }

//  static getPacientes() {
//    final list = List<Paciente>();
//
//    list.add(Paciente("Pedro Soares da Silva", "Hoje ele está contente"));
//    list.add(Paciente("Amanda Alves", "Acordou um pouco cansada"));
//    list.add(Paciente("Julho Fonseca", "Acordeou estressado"));
//
//    return list;
//  }
}
