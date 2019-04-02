import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/domain/paciente.dart';
import 'package:projeto_sentir/domain/paciente_service.dart';
import 'package:projeto_sentir/drawer_list_psicologa.dart';
import 'package:projeto_sentir/pages/diario_psicologa_page.dart';
import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';

class PsicologaPage extends StatefulWidget {
  @override
  _PsicologaPageState createState() => _PsicologaPageState();
}

class _PsicologaPageState extends State<PsicologaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pacientes"),
        backgroundColor: Colors.blue,
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
      body: _body(context),
      drawer: DrawerMenu(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Cores.azul,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
                trailing: InkWell(
                  onTap: () {
                    _onclickAtivarDestivar(context, paciente.id);
                  },
                  child: Text(
                      ( paciente.ativo.toString() == "1" ? "Ativo" : "Desativado"),
                    style: TextStyle(
                      color: Colors.black38
                    ),
                  ),
                ),

//                leading:
                leading: Image.asset(
                  "assets/images/icon_diario_blue_70px.jpg",
                  width: 40,
                ),
                onTap: (){
                  _acessarDiario(context, paciente.id, paciente.nome);
                },
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
  }

  void _onClickSair(BuildContext context) async {
    final usuario = await LoginService.logout();
    pushReplacement(context,LoginPage());
  }

  void _acessarDiario(BuildContext context, int id, String nome) {
    push(context,DiarioPsicologaPage(id, nome));
  }

  _onclickAtivarDestivar(BuildContext context, int id) async {
   try{
      final paciente = await PacienteService.ativardesativar(id);
      pushReplacement(context, PsicologaPage());
    } catch(error) {
      alert(context, "Erro","Ocorreu um erro ao ativar ou desativar o paciente");
    }
  }
}
