import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/psicologa.dart';
import 'package:projeto_sentir/domain/usuario.dart';
import 'package:projeto_sentir/utils/prefs.dart';

//{"result":"22","token":"30deabeb5a4c69fabd5124bd95f7c7e0","error":"","codigo":"000022","nome":"usuario","perfil":"ps"}

class PsicologaService {
  static Future<Psicologa> cadastro(String nome, String login, String senha) async {
    var url = "http://lpmweb.com.br/projetosentir/psicologa/inserir";

    final response =
         await http.post(url, body: {"nome": nome, "email": login, "senha": senha, "perfil":"ps"});

    final s = response.body;
    print("Retorno api >> $s");

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

  static Future<Psicologa> alterar(String nome, String senha) async {
    var url = "http://lpmweb.com.br/projetosentir/sistema/alterarPerfil";
    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");

    final response = await http.post(url, body: {"nome": nome, "senha": senha, "email":login,"token":token, "perfil":"ps"});

    final s = response.body;
    print("resposta $s");

    final map = json.decode(s);

    final p = Psicologa.fromJson(map);

//    print("> $p");
//    final u = await Usuario.get();

    Prefs.setString("perfil", "ps");
    Prefs.setString("nome", nome);

    return p;
  }
}
