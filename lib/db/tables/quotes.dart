import 'package:drift/drift.dart';
import 'package:drifttest/db/tables/users.dart';

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quote => text()();
  TextColumn get authorId =>
      text().references(Users, #userId)();
}

class QuotesClass {
  final int id;
  final String quote;
  final int authorId;

  QuotesClass({
    required this.id,
    required this.quote,
    required this.authorId,
  });
}
