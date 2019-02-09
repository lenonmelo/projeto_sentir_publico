
class Paciente {
  final int id;
  final String nome;
  final String email;
  final String mesentindo;

  Paciente(this.id,this.nome, this.email, this.mesentindo);

  Paciente.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        nome = map["nome"],
        email = map["email"],
        mesentindo = map["mesentindo"];
}