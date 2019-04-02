import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/pages/altera_psicologa_page.dart';
import 'package:projeto_sentir/pages/psicologa_page.dart';
import 'package:projeto_sentir/utils/nav.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class DrawerMenu extends StatelessWidget {
  final BuildContext mainContext;

  DrawerMenu(this.mainContext);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: _getItems(context),
      ),
    );
  }

  ListView _getItems(BuildContext context) {

    final drawerItems = ListView(
      children: <Widget>[
        //drawerHeader,
        Container(
          color: Cores.azul,
          height: 180,
          child:
            ListView(
              children: <Widget>[
                Image.asset("assets/images/logo_300px.png"),
                Center(
                  child:InkWell(
                    onTap: () {
                      _verDetalhe(context);
                    },
                    child: FutureBuilder(
                      future:  Prefs.getString("nome"),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          final nome = snapshot.data;
                          return Text(nome,
                            style: TextStyle(
                                fontSize: 20
                            ),
                          );
                        }
                        return Text("");
                      },
                    ),
                  ),
                ),
                Center(
                  child: FutureBuilder(
                    future: Prefs.getString("codigo"),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        final codigo = snapshot.data;
                        return Text("Código:${codigo}",
                            style: TextStyle(
                                fontSize: 16
                            ));
                      }
                      return Text("");
                    },
                  ),
                ),

              ],
            ),
        ),
        ListTile(
          leading: Image.asset(
              "assets/images/icon_diario_70px.jpg",
              width: 40,
          ),
          title: Text("Diários dos paciente"),
          onTap: () => {
              pushReplacement(context, PsicologaPage())
          }
        ),
        ListTile(
            leading: Icon(
              Icons.account_box,
              size: 50,
            ),
            title: Text("Alterar perfil"),
            onTap: () => {
              _verDetalhe(context)
            }
        ),
        Divider(),
      ],
    );
    return drawerItems;
  }
  void _verDetalhe(BuildContext context) {
    push(context, AlteraPsicologaPage());
  }
}
