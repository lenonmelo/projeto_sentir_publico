
class Psicologa {
  final int id;
  final String token;
  final String error;
  final String codigo;
  final String nome;


  Psicologa(this.id, this.token, this.error, this.codigo, this.nome);

  Psicologa.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["result"]),
        token = map["token"],
        error = map["error"],
        codigo = map["codigo"],
        nome = map["nome"];

  bool isOk() {
    return error == null || error.isEmpty;
  }

  @override
  String toString() {
    return 'Psicologa{id: $id, token: $token, error: $error, codigo: $codigo, nome: $nome}';
  }
}