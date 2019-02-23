
class Usuario {
  final int id;
  final String token;
  final String error;
  final String codigo;
  final String nome;
  final String foto;
  final String perfil;

  Usuario(this.id, this.token, this.error, this.codigo, this.nome,this.foto, this.perfil);

  Usuario.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["result"]),
        token = map["token"],
        error = map["error"],
        codigo = map["codigo"],
        nome = map["nome"],
        foto = map["foto"],
        perfil = map["perfil"];

  bool isOk() {
    return error == null || error.isEmpty;
  }

  @override
  String toString() {
    return 'Usuario{id: $id, token: $token, error: $error, codigo: $codigo, nome: $nome, perfil: $perfil, foto: $foto}';
  }
}