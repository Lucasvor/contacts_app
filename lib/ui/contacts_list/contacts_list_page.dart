import 'package:contacts_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'widget/contact_tile.dart';

class ContactsListPage extends StatefulWidget {
  // _ siginifica que uma propriedade é privada.
  @override
  _ContactsListPageState createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  // runs when the state changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ScopedModelDescendant<ContactsModel>(
          builder: (context, child, model) {
        return ListView.builder(
          itemCount: model.contacts.length,
          //runs & builds every single list item
          itemBuilder: (context, index) {
            return ContactTile(
              contactIndex: index,
            );
          },
        );
      }),
    );
  }
}
