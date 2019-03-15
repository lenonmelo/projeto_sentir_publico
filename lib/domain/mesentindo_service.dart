import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/mesentindo.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class MesentindoService {
  static Future<List<Mesentindo>> getSentimentos() async {
    var url = "http://lpmweb.com.br/projetosentir/diario/listaMeSentindo";
//    http://projeto.sentir.com.br/diario/listaMeSentindo
    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");
//    print("Login > $login");
    final perfil = await Prefs.getString("perfil");

    final response = await http.post(url, body: {
      "email": login,
      "token": token,
      "perfil": perfil
    });

    final s = response.body;
    print("paciente > $s");

    final mapSentimentos = json.decode(s).cast<Map<String, dynamic>>();

    final sentimentos = mapSentimentos.map<Mesentindo>((json) => Mesentindo.fromJson(json)).toList();
    print("sentimentos > $sentimentos");
    return sentimentos;
  }

}
