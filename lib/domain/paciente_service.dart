import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_sentir/domain/paciente.dart';
import 'package:projeto_sentir/domain/usuario.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class PacienteService {
  static Future<List<Paciente>> getPacientes() async {
    var url = "http://lpmweb.com.br/projetosentir/diario/listapacientes";

    //final user = await Usuario.get();

    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");
    //print("Login > $login");

    final body = {
    "email": login,
    "token": token,
    "perfil": "ps"
    };

//    print("post body getpacientes $body");

    final response = await http.post(url,body: body );

    final s = response.body;
//    print("paciente > $s");

    final mapPacientes = json.decode(s).cast<Map<String, dynamic>>();

    final paciente = mapPacientes.map<Paciente>((json) => Paciente.fromJson(json)).toList();
//    print("pacienteaaaa > $paciente");
    return paciente;
  }
  static Future<Paciente> cadastro(String nome, String login, String senha, String codigo) async {
    var url = "http://lpmweb.com.br/projetosentir/paciente/inserir";
    Prefs.clear();
    final response =
    await http.post(url, body: {"nome": nome, "email": login, "senha": senha, "cod_psicologa": codigo ,"perfil":"pa"});

    final s = response.body;
    print("cadastro paciente > $s");

    final map = json.decode(s);

    final p = Paciente.fromJson(map);

//    print("> $p");
    Prefs.setString("token", p.token);
    Prefs.setString("psicologa", p.psicologa);
    Prefs.setString("login", login);
    Prefs.setString("perfil", "pa");
    Prefs.setString("nome", nome);
    Prefs.setString("codigo", codigo);

    return p;
  }

  static Future<Paciente> alterar(String nome, String senha) async {
    var url = "http://lpmweb.com.br/projetosentir/sistema/alterarPerfil";
    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");

    final response = await http.post(url, body: {"nome": nome, "senha": senha, "email":login,"token":token, "perfil":"pa"});

    final s = response.body;
    print("resposta $s");

    final map = json.decode(s);

    final p = Paciente.fromJson(map);

//    print("> $p");

    Prefs.setString("perfil", "pa");
    Prefs.setString("nome", nome);

    return p;
  }

  static Future<Paciente> ativardesativar(int id) async {
    var url = "http://lpmweb.com.br/projetosentir/diario/desativarPaciente";
    final token = await Prefs.getString("token");
//    print("Tokenaaaaa > $token");

    final login = await Prefs.getString("login");

    final response = await http.post(url, body: {"id": id.toString(),"email":login,"token":token, "perfil":"ps"});

    final s = response.body;
    print("resposta $s");

    final map = json.decode(s);

    final p = Paciente.fromJson(map);

    return p;
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
