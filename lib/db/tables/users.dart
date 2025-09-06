import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get userId => text()();
  TextColumn get email => text()();
  TextColumn get password => text()();
  TextColumn get firstName => text()();
  // TextColumn get secondName => text().nullable()();
  @override
  Set<Column> get primaryKey => {userId}; // 👈 this makes userId the PK
}

class UserClass {
  final String userId;
  final String email;
  final String password;
  final String firstName;
  final String? secondName;

  UserClass({
    required this.userId,
    required this.email,
    required this.password,
    required this.firstName,
    this.secondName,
  });
}
