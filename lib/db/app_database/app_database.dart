import 'package:drift/drift.dart';
import 'package:drifttest/db/daos/logged_in_user_dao/logged_in_dao.dart';
import 'package:drifttest/db/daos/quote_doa/quote_dao.dart';
import 'package:drifttest/db/daos/user_daa/user_dao.dart';
import 'package:drifttest/db/tables/logged_in.dart';
import 'package:drifttest/imports/connection.dart';
import 'package:drifttest/db/tables/quotes.dart';
import 'package:drifttest/db/tables/users.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Quotes, Users, LoggedIn],
  daos: [UsersDao, QuotesDao, LoggedInDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? openConnection());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // For dev: wipe everything and recreate
      await m.deleteTable('quotes');
      await m.deleteTable('users');
      await m.deleteTable('logged_in'); // 👈 add this
      await m.createAll(); // recreate all tables
    },
  );

  // static QueryExecutor _openConnection() {
  //   return driftDatabase(
  //     name: 'my_database',
  //     native: const DriftNativeOptions(
  //       databaseDirectory: getApplicationSupportDirectory,
  //     ),
  //   );
  // }
}
