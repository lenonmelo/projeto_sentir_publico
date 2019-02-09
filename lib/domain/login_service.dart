import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/usuario.dart';
import 'package:projeto_sentir/utils/prefs.dart';

//{"result":"22","token":"30deabeb5a4c69fabd5124bd95f7c7e0","error":"","codigo":"000022","nome":"usuario","perfil":"ps"}

class LoginService {
  static Future<Usuario> login(String login, String senha) async {
    var url = "http://lpmweb.com.br/projetosentir/sistema/login";

    final response =
         await http.post(url, body: {"login": login, "senha": senha});

    final s = response.body;
    print(s);

    final map = json.decode(s);

    final u = Usuario.fromJson(map);

    print("> $u");

    Prefs.setString("codigo", u.codigo);
    Prefs.setString("token", u.token);
    Prefs.setString("login", login);
    Prefs.setString("perfil", "ps");
    Prefs.setString("nome", u.nome);

    return u;
  }
}
