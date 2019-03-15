
class Login {
  final String sucesso;
  final String result;
  final String error;
  final String deslogar;


  Login(this.sucesso, this.result, this.error, this.deslogar);

  Login.fromJson(Map<String,dynamic> map) :
        sucesso = map["sucesso"],
        result = map["result"],
        error = map["error"],
        deslogar = map["deslogar"];
}