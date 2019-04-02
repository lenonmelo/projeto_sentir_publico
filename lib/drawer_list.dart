import 'package:flutter/material.dart';

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
          title: Text("Item 1"),
          onTap: () => print("1"),
        ),
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text("Item 2"),
          onTap: () => print("2"),
        ),
        ListTile(
          leading: Icon(Icons.directions_car),
          title: Text("Item 3"),
          onTap: () => print("3"),
        ),
        Divider(),
      ],
    );
    return drawerItems;
  }

  UserAccountsDrawerHeader _getHeader() {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Ricardo Lecheta'),
      accountEmail: Text('rlecheta@gmail.com'),
      currentAccountPicture: CircleAvatar(
        child: Image.network("https://www.clubdocondominio.com.br/images/default-avatar-ginger-guy.png"),
        backgroundColor: Colors.white,
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(
          child: Text('A'),
          backgroundColor: Colors.yellow,
        ),
        CircleAvatar(
          child: Text('B'),
          backgroundColor: Colors.red,
        )
      ],
    );
    return drawerHeader;
  }

}
