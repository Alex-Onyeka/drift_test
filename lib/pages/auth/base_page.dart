import 'package:drifttest/auth_service/auth_service.dart';
import 'package:drifttest/db/app_database/app_database.dart';
import 'package:drifttest/main.dart';
import 'package:drifttest/pages/auth/auth_base.dart';
import 'package:drifttest/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
    var db = returnDb(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? userId = await db.loggedInDao.getLoggedInId();
      print('Logged UserId Returned: $userId');
      User? user = await db.usersDao.getUserById(userId);
      print('Main User Returned: ${user?.firstName}');
      if (context.mounted) {
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AuthBase();
              },
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: CircularProgressIndicator()),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            AuthService().logOut(context);
            returnDb(context).usersDao.deleteAllUsers();
          },
          child: Text('Logout'),
        ),
      ),
    );
    // var db = returnDb(context);
    // return FutureBuilder(
    //   future: db.loggedInUserDao.getLoggedInUser(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState ==
    //         ConnectionState.waiting) {
    //       return Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Scaffold(
    //         body: Center(
    //           child: Text(
    //             'An Error Occured: ${snapshot.error.toString()}',
    //           ),
    //         ),
    //       );
    //     } else {
    //       User? user = snapshot.data;
    //       if (user == null) {
    //         return AuthBase();
    //       } else {
    //         return HomePage();
    //       }
    //     }
    //   },
    // );
  }
}
