
class Diario {
  final int id;
  final String situacao;
  final String mesentindo;
  final String oquefiz;
  final String error;
  final String data;

  Diario(this.id, this.situacao, this.mesentindo, this.oquefiz, this.error, this.data);

  Diario.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        situacao = map["situacao"],
        mesentindo = map["sentimento"],
        oquefiz = map["oquefiz"],
        error = map["error"],
        data = map["data_criacao"];
}