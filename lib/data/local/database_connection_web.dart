import 'package:drift/drift.dart';
import 'package:drift/web.dart';

Future<QueryExecutor> openDatabaseConnection() async {
  return WebDatabase('fashion_closet');
}