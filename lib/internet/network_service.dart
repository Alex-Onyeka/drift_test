import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drifttest/auth_service/auth_service.dart';
import 'package:drifttest/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show Session;

import '../db/app_database/app_database.dart' show User;

class NetworkService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  AuthService authService = AuthService();
  late StreamSubscription<List<ConnectivityResult>>
  subscription;

  NetworkService(BuildContext context) {
    init(context);
  }

  Session? isAuthenticated() {
    return authService.client.auth.currentSession;
  }

  void saveUserCatch(User userNew) {
    userCache = userNew;
    print('User cached Locally: ${userCache?.firstName}');
    notifyListeners();
  }

  void deleteUserCache() {
    userCache = null;
    notifyListeners();
  }

  User? userCache;

  // bool isData = false;
  String isConnected = 'Loading';

  String isLoggedIn = 'Loading';
  void checkUserOffline() {
    if (isAuthenticated() == null) {
      isLoggedIn = 'Offline User';
    } else {
      isLoggedIn = 'Authenticated User';
    }
    notifyListeners();
  }

  Color color = Colors.amber;
  void init(BuildContext context) {
    subscription = connectivityStream.listen((value) async {
      print(
        'Length of Connected Networks: ${value.length}',
      );
      // value.isNotEmpty ? isData = true : isData = false;
      value.isNotEmpty
          ? {isConnected = 'Online'}
          : {isConnected = 'Offline'};
      print('Network state changed: $isConnected');
      print(
        'Auth Session: ${isAuthenticated().toString()}',
      );
      print('Local Cached User: ${userCache?.firstName}');
      value.isNotEmpty
          ? color = Colors.green
          : color = Colors.grey;
      notifyListeners();

      if (context.mounted) {
        if (isAuthenticated() == null) {
          User? user = await returnDb(
            context,
          ).usersDao.getLoggedInUser(context);
          if (user != null) {
            await authService.loginOnline(
              email: user.email,
              password: user.password,
            );
            checkUserOffline();
          }
        }
      }

      if (context.mounted) {
        String? userId =
            await returnDb(
              context,
            ).loggedInDao.getLoggedInId();
        if (isAuthenticated() != null && userId == null) {
          await authService.logOutOnline();
          checkUserOffline();
        }
      }
      checkUserOffline();
      print(
        'Auth Session: ${isAuthenticated().toString()}',
      );

      notifyListeners();
    });
  }

  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged.map((results) {
        // Return the first non-none result, or none if all are none
        return results
            .where(
              (result) =>
                  result != ConnectivityResult.none &&
                  // result != ConnectivityResult.bluetooth &&
                  result != ConnectivityResult.other &&
                  result != ConnectivityResult.vpn,
            )
            .toList();
      });

  Future<bool> isOnline() async {
    final results = await _connectivity.checkConnectivity();
    print('Connectivity results: $results');
    return results.any(
      (result) =>
          result != ConnectivityResult.none &&
          result != ConnectivityResult.bluetooth &&
          result != ConnectivityResult.other &&
          result != ConnectivityResult.vpn,
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
