import 'package:drift/drift.dart';
import 'package:drifttest/db/app_database/app_database.dart';
import 'package:drifttest/db/tables/logged_in.dart';

part 'logged_in_dao.g.dart';

@DriftAccessor(tables: [LoggedIn])
class LoggedInDao extends DatabaseAccessor<AppDatabase>
    with _$LoggedInDaoMixin {
  final AppDatabase db;
  LoggedInDao(this.db) : super(db);

  // CRUD --------- METHODS
  Future<String?> getLoggedInId() async {
    final user =
        await db.select(db.loggedIn).getSingleOrNull();
    print('Logged UserId gotten');
    return user?.beans;
  }

  Future<void> insertLoggedIn(String beans) async {
    await deleteLoggedIn();
    await db
        .into(db.loggedIn)
        .insert(
          LoggedInCompanion.insert(beans: Value(beans)),
        );
    print('User Logged In: $beans Offline');
  }

  /// Delete the logged-in user (logout)
  Future<int> deleteLoggedIn() async {
    return await db.delete(db.loggedIn).go();
  }
}
