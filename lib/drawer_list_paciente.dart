import 'package:flutter/material.dart';
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

    UserAccountsDrawerHeader drawerHeader = _getHeader();

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text("Diário das emoções"),
          onTap: () => print("1"),
        ),

        Divider(),
      ],
    );
    return drawerItems;
  }

  UserAccountsDrawerHeader _getHeader() {

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
      currentAccountPicture: CircleAvatar(
        child: Image.network("https://www.clubdocondominio.com.br/images/default-avatar-ginger-guy.png"),
        backgroundColor: Colors.white,
      ),
      onDetailsPressed: verDetalhe,
    );
    return drawerHeader;
  }

  void _logout() {
    Navigator.pop(mainContext);
  }

  void verDetalhe() {
    print('detalhe');
  }
}
