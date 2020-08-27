import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class AppdDataBase {
  static final AppdDataBase _singleton = AppdDataBase._();

  static AppdDataBase get instance => _singleton;
  Completer<Database> _dbOpenCompleter;

  AppdDataBase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDataBase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDataBase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'contacts.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter.complete(database);
  }
}
