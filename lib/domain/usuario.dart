import 'dart:convert';

import 'package:projeto_sentir/utils/prefs.dart';

class Usuario {
  final int id;
  final String token;
  final String error;
  final String codigo;
  final String nome;
  final String foto;
  final String perfil;
  final String psicologa;

  Usuario(this.id, this.token, this.error, this.codigo, this.nome,this.foto, this.perfil, this.psicologa);

  Usuario.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        token = map["token"],
        error = map["error"],
        codigo = map["codigo"],
        nome = map["nome"],
        foto = map["foto"],
        perfil = map["perfil"],
        psicologa = map["psicologa"];

  Map toMap() {
    final map = Map<String,dynamic>();
    map["id"] = "$id";
    map["token"]= token;
    map["codigo"] = codigo;
    map["nome"] = nome;
    map["foto"] = foto;
    map["perfil"] = perfil;
    map["psicologa"] = psicologa;
    return map;
  }

  bool isOk() {
    return error == null || error.isEmpty;
  }

  void save() {
    final map = toMap();
    final s = json.encode(map);
    Prefs.setString("user", s);
  }

  static Future<Usuario> get() async {
    String s = await Prefs.getString("user");
    final map = json.decode(s) as Map<String,dynamic>;
    final user = Usuario.fromJson(map);
    return user;
  }

  @override
  String toString() {
    return 'Usuario{id: $id, token: $token, error: $error, codigo: $codigo, nome: $nome, perfil: $perfil, foto: $foto}';
  }
}