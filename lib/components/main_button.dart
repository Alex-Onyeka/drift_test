import 'package:drifttest/functions/general_constants.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function()? action;
  const MainButton({
    super.key,
    GlobalKey<FormState>? formKey,
    required this.text,
    required this.action,
  }) : _formKey = formKey;

  final GlobalKey<FormState>? _formKey;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 4, 131, 118),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          if (_formKey != null) {
            if (_formKey.currentState!.validate()) {
              action!();
            }
          } else {
            action!();
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 30,
          ),
          child: Center(
            child: Text(
              style: TextStyle(
                color: Colors.white,
                fontSize: Fonts().subTitlte_14,
                fontWeight: FontWeight.bold,
              ),
              text,
            ),
          ),
        ),
      ),
    );
  }
}
