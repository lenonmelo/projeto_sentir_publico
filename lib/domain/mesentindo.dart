
class Mesentindo {
  final int id;
  final String sentimento;

  Mesentindo(this.id, this.sentimento);

  Mesentindo.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        sentimento = map["sentimento"];
}