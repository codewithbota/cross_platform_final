import 'package:drift/drift.dart';
import 'package:drift/web.dart' // ignore: deprecated_member_use
    ;

Future<QueryExecutor> openDatabaseConnection() async {
  return WebDatabase('fashion_closet_db');
}
