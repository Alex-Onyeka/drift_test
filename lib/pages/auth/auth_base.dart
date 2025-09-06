import 'package:drifttest/pages/auth/create_account.dart';
import 'package:drifttest/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class AuthBase extends StatefulWidget {
  const AuthBase({super.key});

  @override
  State<AuthBase> createState() => _AuthBaseState();
}

class _AuthBaseState extends State<AuthBase> {
  bool isLogginPage = true;
  @override
  Widget build(BuildContext context) {
    if (isLogginPage) {
      return GestureDetector(
        onTap:
            () =>
                FocusManager.instance.primaryFocus
                    ?.unfocus(),
        child: LoginPage(
          switchPage: () {
            setState(() {
              isLogginPage = false;
            });
          },
        ),
      );
    } else {
      return GestureDetector(
        onTap:
            () =>
                FocusManager.instance.primaryFocus
                    ?.unfocus(),
        child: CreateAccount(
          switchPage: () {
            setState(() {
              isLogginPage = true;
            });
          },
        ),
      );
    }
  }
}
