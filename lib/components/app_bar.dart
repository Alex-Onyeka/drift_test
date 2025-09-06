import 'package:flutter/material.dart';

appBar({
  required String title,
  Function()? action1,
  IconData? w1,
  Function()? action2,
  IconData? w2,
}) {
  return AppBar(
    toolbarHeight: 70,
    title: Text(
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      title,
    ),
    centerTitle: true,
    actions: [
      Visibility(
        visible: w1 != null,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: action1,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(w1 ?? Icons.add),
          ),
        ),
      ),
      SizedBox(width: 5),
      Visibility(
        visible: w2 != null,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: action2,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(w2 ?? Icons.add),
          ),
        ),
      ),
      SizedBox(width: 10),
    ],
  );
}
