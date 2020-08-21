import 'package:contacts_app/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart' as faker;

class ContactsListPage extends StatelessWidget {
  // _ siginifica que uma propriedade é privada.
  List<Contact> _contacts = List.generate(50, (index) {
    return Contact(
      name: faker.Person().firstName() + ' ' + faker.Person().lastName(),
      email: faker.Internet().freeEmail(),
      phoneNumber: faker.RandomGenerator().integer(1000000).toString(),
    );
  });

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
          return ListTile(
            title: Text(_contacts[index].name),
            subtitle: Text(_contacts[index].email),
          );
        },
      ),
    );
  }
}
