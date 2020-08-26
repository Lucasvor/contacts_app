import 'dart:io';

import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  final Contact editedContact;
  final int editedcontactindex;
  ContactForm({Key key, this.editedContact, this.editedcontactindex})
      : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _phoneNumber;
  File _contactImageFile;
  bool get isEditMode => widget.editedContact != null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(children: <Widget>[
        SizedBox(height: 10),
        _buildContactPicture(),
        SizedBox(height: 10),
        TextFormField(
          onSaved: (value) => _name = value,
          validator: _validateName,
          initialValue: widget.editedContact?.name,
          decoration: InputDecoration(
            labelText: "Nome",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          onSaved: (value) => _email = value,
          validator: _validateEmail,
          initialValue: widget.editedContact?.email,
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          onSaved: (value) => _phoneNumber = value,
          //validator: _validatePhone,
          initialValue: widget.editedContact?.phoneNumber,
          decoration: InputDecoration(
            labelText: "Telefone",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        SizedBox(height: 10),
        RaisedButton(
          onPressed: _onSaveContactButtonPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Salvar"),
              Icon(
                Icons.person,
                size: 18,
                color: Colors.white,
              )
            ],
          ),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        )
      ]),
    );
  }

  Widget _buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 2;
    return Hero(
      // If there are no matching tags found in both routes,
      // hero animation will not happen.
      tag: widget.editedContact?.hashCode ?? Icon(Icons.person),
      child: GestureDetector(
        onTap: _onContactPictureTapped,
        child: CircleAvatar(
          radius: halfScreenDiameter / 4,
          child: _buildCircleAvatarContent(halfScreenDiameter),
        ),
      ),
    );
  }

  void _onContactPictureTapped() async {
    final _picker = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _contactImageFile = File(_picker.path);
    });
  }

  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (isEditMode) {
      if (_contactImageFile == null) {
        return Text(
          widget.editedContact.name[0],
          style: TextStyle(fontSize: halfScreenDiameter / 4),
        );
      } else {
        return ClipOval(
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.file(
              _contactImageFile,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    } else {
      return Icon(
        Icons.person,
        size: halfScreenDiameter / 4,
      );
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Coloque um nome';
    }
    return null;
  }

  String _validateEmail(String value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    if (value.isEmpty) {
      return "Coloque um email válido";
    } else if (!emailRegex.hasMatch(value)) {
      return "Coloque um email válido";
    }
    return null;
  }

  String _validatePhone(String value) {
    final phoneRegex =
        RegExp(r"(\d{2}|\d{0})[-. ]?(\d{5}|\d{4})[-. ]?(\d{4})[-. ]?");
    if (value.isEmpty) {
      return "Coloque um Telefone válido";
    } else if (!phoneRegex.hasMatch(value)) {
      return "Coloque um Telefone válido";
    }
    return null;
  }

  void _onSaveContactButtonPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final newOrEditedContact = Contact(
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
        isFavorite: widget.editedContact?.isFavorite ?? false,
      );

      if (isEditMode) {
        ScopedModel.of<ContactsModel>(context)
            .updateContact(newOrEditedContact, widget.editedcontactindex);
      } else {
        ScopedModel.of<ContactsModel>(context).addContact(newOrEditedContact);
      }
      Navigator.of(context).pop();
    }
  }
}
