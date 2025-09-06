import 'package:drift/drift.dart';
import 'package:drifttest/db/app_database/app_database.dart';
import 'package:drifttest/db/tables/users.dart';
import 'package:drifttest/internet/network_service.dart';
import 'package:drifttest/main.dart';
import 'package:flutter/material.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase>
    with _$UsersDaoMixin {
  final AppDatabase db;
  UsersDao(this.db) : super(db);

  // CRUD --------- METHODS

  Future<List<User>> getUsers() async {
    return await db.select(users).get();
  }

  Future<User?> getUserById(String? id) async {
    User? user =
        await (select(users)..where(
          (user) => user.userId.equals(id ?? 'Alternative'),
        )).getSingleOrNull();
    print('Main User Gotten');
    return user;
  }

  Future<User?> getUserByEmail(String email) async {
    return await (select(users)..where(
      (user) => user.email.equals(email),
    )).getSingleOrNull();
  }

  Future<int?> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String userId,
    required BuildContext context,
  }) async {
    var res = await db
        .into(db.users)
        .insert(
          UsersCompanion.insert(
            userId: userId,
            email: email,
            password: password,
            firstName: firstName,
          ),
        );
    if (context.mounted) {
      User? userTemp = await getLoggedInUser(context);
      if (context.mounted) {
        userTemp != null
            ? NetworkService(
              context,
            ).saveUserCatch(userTemp)
            : {};
      }
    }

    print('User Registered Locally: $firstName');
    return res;
  }

  Future<User?> getLoggedInUser(
    BuildContext context,
  ) async {
    String? userId =
        await returnDb(context).loggedInDao.getLoggedInId();

    return await getUserById(userId);
  }

  Future<User?> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    final hashed = password;
    final user =
        await (db.select(db.users)..where(
          (u) =>
              u.email.equals(email) &
              u.password.equals(hashed),
        )).getSingleOrNull();
    print('Logged in Offline now : ${user?.firstName}');
    if (context.mounted) {
      user != null
          ? NetworkService(context).saveUserCatch(user)
          : {};
    }

    print('This is the new Print: ${user?.firstName}');

    return user;
  }

  Future<bool> updateUser(User user) async {
    return db.update(users).replace(user);
  }

  Future deleteUser(String userId) {
    return (db.delete(users)
      ..where((user) => user.userId.equals(userId))).go();
  }

  Future deleteAllUsers() {
    return (db.delete(users)).go();
  }
}
