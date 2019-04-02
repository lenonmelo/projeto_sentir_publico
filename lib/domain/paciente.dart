class Paciente {
  final int id;
  final String nome;
  final String mesentindo;
  final String error;
  final String sucesso;
  final String token;
  final String psicologa;
  final String ativo;

  Paciente(this.id, this.nome,this.mesentindo, this.error, this.sucesso, this.token, this.psicologa, this.ativo);

  Paciente.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        nome = map["nome"],
        mesentindo = map["mesentindo"],
        error = map["error"],
        sucesso = map["sucesso"].toString(),
        token = map["token"],
        psicologa = map["psicologa"],
        ativo = map["ativo"];

  bool isOk() {
    return error == null || error.isEmpty;
  }

  @override
  String toString() {
    return 'Paciente{id: $id, nome: $nome, mesentindo: $mesentindo, error: $error, sucesso: $sucesso, token: $token, psicologa: $psicologa, ativo: $ativo}';
  }


}
