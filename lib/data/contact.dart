import 'package:flutter/cupertino.dart';

class Contact {
  String name;
  String email;
  String phoneNumber;

  // Construtor com parametros opcional
  Contact(
      //@required faz que seja obrigatorio aquele campo não podendo passar nulo.
      {@required this.name,
      @required this.email,
      @required this.phoneNumber});
}
