
class Diario {
  final int id;
  final int id_paciente;
  final String situacao;
  final String mesentindo;
  final String oquefiz;
  final String error;
  final String data;
  final String nome_paciente;

  Diario(this.id, this.id_paciente, this.situacao, this.mesentindo, this.oquefiz, this.error, this.data, this.nome_paciente);

  Diario.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        situacao = map["situacao"],
        mesentindo = map["mesentindo"],
        oquefiz = map["oquefiz"],
        error = map["error"],
        data = map["data_criacao"],
        id_paciente = int.parse(map["id_paciente"]),
        nome_paciente = map["nome_paciente"];

  @override
  String toString() {
    return 'Diario{id: $id, id_paciente: $id_paciente, situacao: $situacao, mesentindo: $mesentindo, oquefiz: $oquefiz, error: $error, data: $data, nome_paciente: $nome_paciente}';
  }


}