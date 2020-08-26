import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactEditPage extends StatelessWidget {
  final Contact editedContact;
  final int editedcontactindex;

  ContactEditPage(
      {Key key,
      @required this.editedContact,
      @required this.editedcontactindex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edite o contato"),
      ),
      body: ContactForm(
        editedContact: editedContact,
        editedcontactindex: editedcontactindex,
      ),
    );
  }
}
