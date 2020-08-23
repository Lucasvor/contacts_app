import 'package:contacts_app/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker;

import 'widget/contact_tile.dart';

class ContactsListPage extends StatefulWidget {
  // _ siginifica que uma propriedade é privada.
  @override
  _ContactsListPageState createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  List<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = List.generate(50, (index) {
      return Contact(
        name: faker.Person().firstName() + ' ' + faker.Person().lastName(),
        email: faker.Internet().freeEmail(),
        phoneNumber: faker.RandomGenerator().integer(1000000).toString(),
      );
    });
  }

// runs when the state changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        //runs & builds every single list item
        itemBuilder: (context, index) {
          return ContactTile(contacts: _contacts);
        },
      ),
    );
  }
}