class Paciente {
  final int id;
  final String nome;
  final String mesentindo;
  final String foto;
  final String error;

  Paciente(this.id, this.nome,this.mesentindo,this.foto, this.error);

  Paciente.fromJson(Map<String,dynamic> map) :
        id = int.parse(map["id"]),
        nome = map["nome"],
        mesentindo = map["mesentindo"],
        foto = map["foto"],
        error = map["error"];
}
