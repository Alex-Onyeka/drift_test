import 'package:drifttest/db/app_database/app_database.dart'
    show User;
import 'package:flutter/material.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

const double mobileScreen = 550;
const double tabletScreen = 950;
const double tabletBig = 1040;

// FONTS
class Fonts {
  final double mainHeading_25 = 25;
  final double subHeading_30 = 20;
  final double mainTitle_18 = 18;
  final double subTitlte_14 = 14;
  final double smallText_12 = 12;
  final double smallerText_10 = 10;
  final double smallestText_8 = 8;
}

extension UserMapper on User {
  static User fromMap(
    Map<String, dynamic> map, {
    required String password,
    required BuildContext context,
  }) {
    // var hashed = hashPassword(password);
    return User(
      userId: (map['user_id'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: password, // 👈 use the one from login()
      firstName: (map['first_name'] ?? '') as String,
    );
  }
}

// String hashPassword(String password) {
//   final bytes = utf8.encode(password);
//   return sha256
//       .convert(bytes)
//       .toString(); // use stronger if needed
// }
