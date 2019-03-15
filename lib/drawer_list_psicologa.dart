import 'package:flutter/material.dart';
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

    UserAccountsDrawerHeader drawerHeader = _getHeader(context);

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text("Diários dos paciente"),
          onTap: () => push(context, PsicologaPage()),
        ),

        Divider(),
      ],
    );
    return drawerItems;
  }

  UserAccountsDrawerHeader _getHeader(BuildContext context) {

    final drawerHeader = UserAccountsDrawerHeader(
      accountName: FutureBuilder(
        future: Prefs.getString("nome"),
        builder: (context, snapshot) {
          final data = snapshot.hasData ? snapshot.data : "";
          return Text("Psicóloga(o): $data");
        },
      ),
      accountEmail: FutureBuilder(
        future: Prefs.getString("codigo"),
        builder: (context, snapshot) {
          final data = snapshot.hasData ? snapshot.data : "";
          return Text("Código: $data");
        },
      ),
      currentAccountPicture:  CircleAvatar(
        child:
          FutureBuilder(
            future: Prefs.getString("foto"),
            builder: (context, snapshot) {
              final foto = snapshot.hasData && snapshot.data != "" ? snapshot.data : "perfil_identity_icon.png";
              return Image.network("http://lpmweb.com.br/projetosentir/fotos/$foto",
                  height: 200,
                  width: 200);
            },
          ),

        backgroundColor: Colors.blue,
      ),

      onDetailsPressed:() {
        _verDetalhe(context);
      },  // verDetalhe,
    );
    return drawerHeader;
  }

  void _logout() {
    Navigator.pop(mainContext);
  }

  void _verDetalhe(BuildContext context) {
    push(context, AlteraPsicologaPage());
  }
}
