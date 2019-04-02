import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/paciente.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class DiarioService {
  static Future<List<Diario>> getDiarios() async {
    var url = "http://lpmweb.com.br/projetosentir/diario/lista";

    final token = await Prefs.getString("token");
//    print("Tokenaaaaaaaaa > $token");
    final login = await Prefs.getString("login");
//    print("Loginaaaaaa > $login");
    final body = {
      "email": login,
      "token": token,
      "perfil": "pa"
    };

    print("post body $body");

    final response = await http.post(url,body: body );

    final s = response.body;
//    print("diarios > $s");
    final mapDiario = json.decode(s).cast<Map<String, dynamic>>();

    final diario = mapDiario.map<Diario>((json) => Diario.fromJson(json)).toList();

    return diario;
  }

  static Future<List<Diario>> getDiariosPaciente(int id_paciente) async {
    var url = "http://lpmweb.com.br/projetosentir/diario/lista";

    final token = await Prefs.getString("token");
//    print("Tokenaaaaaaaaa > $token");
    final login = await Prefs.getString("login");
//    print("Loginaaaaaa > $login");
//print("id paciente $id_paciente");
    final response = await http.post(url, body: {
      "email": login,
      "token": token,
      "id_paciente": id_paciente.toString(),
      "perfil": "ps"
    });

    final s = response.body;
//    print("diariosaaaaa > $s");
    final mapDiario = json.decode(s).cast<Map<String, dynamic>>();

    final diario = mapDiario.map<Diario>((json) => Diario.fromJson(json)).toList();

    return diario;
  }

  static Future<Diario> cadastro(String situacao, String mesenti, String oquefiz) async {
    var url = "http://lpmweb.com.br/projetosentir/diario/inserir";

    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");
    final response =
    await http.post(url, body: {"situacao": situacao, "mesenti": mesenti, "oquefiz":oquefiz,"email":login,"token":token, "perfil":"pa"});

    final s = response.body;
//    print(s);

    final map = json.decode(s);

    final p = Diario.fromJson(map);

    return p;
  }

  static Future<Diario> alterar(String id, String situacao, String mesenti, String oquefiz) async {
    var url = "http://lpmweb.com.br/projetosentir/diario/alterar";

    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");
    final response =
    await http.post(url, body: {"id":id, "situacao": situacao, "mesenti": mesenti, "oquefiz":oquefiz,"email":login,"token":token, "perfil":"pa"});

    final s = response.body;
//    print(s);

    final map = json.decode(s);

    final p = Diario.fromJson(map);

    return p;
  }

  static Future<Diario> getDiario(String id_diario) async {
    var url = "http://lpmweb.com.br/projetosentir/diario/visualizar";

    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");
    final response =
    await http.post(url, body: {"id": id_diario,"email":login,"token":token, "perfil":"pa"});

    final s = response.body;
//    print("Visualizar diario >> ${s}");

    final map = json.decode(s);

    final p = Diario.fromJson(map);

    return p;
  }

  static Future<Diario> excluir(String id) async {
    var url = "http://lpmweb.com.br/projetosentir/diario/excluir";

    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");
    final response =
    await http.post(url, body: {"id":id,"email":login,"token":token, "perfil":"ps"});

    final s = response.body;
    print("Excluir diario >> $s");

    final map = json.decode(s);

    final p = Diario.fromJson(map);

    return p;
  }
}
