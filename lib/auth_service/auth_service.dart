import 'package:drifttest/functions/general_constants.dart';
import 'package:drifttest/internet/network_service.dart';
import 'package:drifttest/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  // final NetworkService _connectivity = NetworkService();

  SupabaseClient get client => _supabase;

  /// Sign up online and sync with Supabase + local Drift
  Future<bool> signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    String? secondName,
  }) async {
    try {
      // Step 1: Supabase Auth signup
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      final user = response.user;

      if (user == null) return false;

      final userId = user.id;

      // Step 2: Insert into Supabase 'users' table
      // final insertResponse =
      await _supabase.from('users').insert({
        'user_id': userId,
        'email': email,
        'first_name': firstName,
        'second_name': secondName,
      });

      // Step 3: Save locally in Drift
      if (context.mounted) {
        await returnDb(
          context,
        ).loggedInDao.insertLoggedIn(userId);
        if (context.mounted) {
          await returnDb(context).usersDao.registerUser(
            userId: userId,
            email: email,
            password: password,
            firstName: firstName,
            context: context,
          );
        }
      }

      return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  /// Offline login using Drift
  Future<bool> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var safeContext = context;
    final isOnline =
        await returnNetwork(context).isOnline();

    if (isOnline) {
      try {
        final response = await _supabase.auth
            .signInWithPassword(
              email: email,
              password: password,
            );

        final user = response.user;
        if (user == null) return false;

        // Refresh local Drift user data
        final userData =
            await _supabase
                .from('users')
                .select()
                .eq('email', email)
                .single();
        print('User Logged in Successfully Online');
        // Clear old user record if needed
        if (context.mounted) {
          await returnDb(
            context,
          ).loggedInDao.insertLoggedIn(userData['user_id']);
        }

        if (context.mounted) {
          var user = UserMapper.fromMap(
            userData,
            password: password,
            context: context,
          );

          NetworkService(context).saveUserCatch(user);

          await returnDb(context).usersDao.updateUser(user);
        }

        return true;
      } catch (e) {
        print('Online login failed: $e');
        return false;
      }
    } else {
      final user = await returnDb(
        safeContext,
      ).usersDao.loginUser(email, password, safeContext);

      if (user != null && context.mounted) {
        await returnDb(
          safeContext,
        ).loggedInDao.insertLoggedIn(user.userId);
        if (context.mounted) {
          NetworkService(safeContext).saveUserCatch(user);
          if (context.mounted) {
            await returnDb(
              context,
            ).usersDao.updateUser(user);
          }
        }
      }

      return user != null ? true : false;
    }
  }

  Future<bool> loginOnline({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth
          .signInWithPassword(
            email: email,
            password: password,
          );

      final user = response.user;
      if (user == null) return false;

      // Refresh local Drift user data
      await _supabase
          .from('users')
          .select()
          .eq('email', email)
          .single();
      print('User Logged in Successfully Online');
      // Clear old user record if needed

      return true;
    } catch (e) {
      print('Online login failed: $e');
      return false;
    }
  }

  Future<void> logOut(BuildContext context) async {
    final isOnline =
        await returnNetwork(context).isOnline();
    if (isOnline) {
      await _supabase.auth.signOut();
    }
    if (context.mounted) {
      returnNetwork(context).deleteUserCache();
      await returnDb(context).loggedInDao.deleteLoggedIn();
    }
  }

  Future<void> logOutOnline() async {
    await _supabase.auth.signOut();
  }
}
