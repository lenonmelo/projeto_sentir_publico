import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/psicologa.dart';
import 'package:projeto_sentir/domain/usuario.dart';
import 'package:projeto_sentir/utils/prefs.dart';

//{"result":"22","token":"30deabeb5a4c69fabd5124bd95f7c7e0","error":"","codigo":"000022","nome":"usuario","perfil":"ps"}

class CadastroPsicologaService {
  static Future<Psicologa> cadastro(String nome, String login, String senha) async {
    var url = "http://192.168.0.107/projetoapi/psicologa/inserir";

    final response =
         await http.post(url, body: {"nome": nome, "email": login, "senha": senha, "perfil":"ps"});

    final s = response.body;
//    print(s);

    final map = json.decode(s);

    final p = Psicologa.fromJson(map);

//    print("> $p");

    Prefs.setString("codigo", p.codigo);
    Prefs.setString("token", p.token);
    Prefs.setString("login", login);
    Prefs.setString("perfil", "ps");
    Prefs.setString("nome", nome);

    return p;
  }
}
