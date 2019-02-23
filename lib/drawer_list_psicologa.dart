import 'package:flutter/material.dart';
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

    UserAccountsDrawerHeader drawerHeader = _getHeader();

    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text("Diário das emoções"),
          onTap: () => push(context, PsicologaPage()),
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
        future: Prefs.getString("codigo"),
        builder: (context, snapshot) {
          return Text(snapshot.hasData ? snapshot.data : "");
        },
      ),
      currentAccountPicture: CircleAvatar(
        child:
          FutureBuilder(
            future: Prefs.getString("foto"),
            builder: (context, snapshot) {

              final foto = snapshot.hasData;
              return Image.network("http://192.168.0.107/projetoapi/fotos/$foto",
                  height: 200,
                  width: 200);
            },
          ),

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
