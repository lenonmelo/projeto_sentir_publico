import 'package:flutter/material.dart';
import 'package:projeto_sentir/pages/altera_paciente_page.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';
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
          title: Text("Diário das emoções"),
          onTap: () => push(context, PacientePage()),
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
          return Text(snapshot.hasData ? snapshot.data : "");
        },
      ),
      accountEmail: FutureBuilder(
        future: Prefs.getString("psicologa"),
        builder: (context, snapshot) {
          final _data = snapshot.data;
          return Text(snapshot.hasData ? "Psic. $_data" : "");
        },
      ),
      currentAccountPicture:  CircleAvatar(
        child:
        FutureBuilder(
          future: Prefs.getString("foto"),
          builder: (context, snapshot) {
            final foto = snapshot.hasData && snapshot.data != "" ? snapshot.data : "perfil_identity_icon.png";
            print("foto ssss> $foto");
            return Image.network("http://lpmweb.com.br/projetosentir/fotos/$foto",
                height: 200,
                width: 200);
          },
        ),

        backgroundColor: Colors.blue,
      ),
        onDetailsPressed:() {
          _verDetalhe(context);
        },
    );
    return drawerHeader;
  }

  void _logout() {
    Navigator.pop(mainContext);
  }

  void _verDetalhe(BuildContext context) {
    push(context, AlteraPacientePage());
  }
}
