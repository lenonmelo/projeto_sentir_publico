import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/domain/paciente.dart';
import 'package:projeto_sentir/domain/paciente_service.dart';
import 'package:projeto_sentir/drawer_list_psicologa.dart';
import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/utils/nav.dart';

class PsicologaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.grey,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _onClickSair(context);
            },
          ),
        ],
      ),
      body: _body2(context),
      drawer: DrawerMenu(context),
    );
  }

  _body2(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Cores.azul,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            "assets/images/diario.png",
            width: 50,
            height: 50,
          ),
          Expanded(
            child: _listView(),
          )
        ],
      ),
    );
  }

  _listView() {
    final pacientes = PacienteService.getPacientes();

    return FutureBuilder(
      future: pacientes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lista = snapshot.data;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, idx) {
              final Paciente paciente = lista[idx];
              final foto = paciente.foto.isEmpty ? "identity_icon.png" : paciente.foto;
              return ListTile(
                title: Text(
                  paciente.nome,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  paciente.mesentindo,
                ),
//                leading:
                leading: Image.network(
                  "http://lpmweb.com.br/projetosentir/fotos/$foto",
                  width: 70,
                  height: 70,
                ),
//                Icon(
//                  Icons.perm_identity,
//                ),

              );
            },
          );
        } else {
          return SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          );
        }
      },
    );

//    return ListView.builder(
//      itemCount: pacientes.length,
//      itemBuilder: (context, idx) {
//        final paciente = pacientes[idx];
//
//        return ListTile(
//          title: Text(
//            paciente.nome,
//            style: TextStyle(
//              color: Colors.black,
//            ),
//          ),
//          subtitle: Text(
//            paciente.desc,
//          ),
//          leading: Icon(
//            Icons.perm_identity,
//          ),
//          trailing: Icon(
//            Icons.star,
//            color: Colors.yellow,
//          ),
//        );
//      },
//    );
  }

  void _onClickSair(BuildContext context) async {
    final usuario = await LoginService.logout();
    push(context,LoginPage());
  }
}
