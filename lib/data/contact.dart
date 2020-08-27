import 'dart:io';

import 'package:flutter/cupertino.dart';

class Contact {
  // Database id (key)
  int id;
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  File imageFile;

  // Construtor com parametros opcional
  Contact(
      //@required faz que seja obrigatorio aquele campo não podendo passar nulo.
      {
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    this.isFavorite = false,
    this.imageFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite ? 1 : 0,
      'imageFilePath': imageFile?.path,
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      isFavorite: map['isFavorite'] == 1 ? true : false,
      // Convert a string containing the path to a File object.
      // If there is an imageFilePath, convert it to File.
      // Otherwise set imageFile to be null.
      imageFile:
          map['imageFilePath'] != null ? File(map['imageFilePath']) : null,
    );
  }
}
