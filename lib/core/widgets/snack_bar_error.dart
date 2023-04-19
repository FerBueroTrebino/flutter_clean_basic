import 'package:flutter/material.dart';

void snackBarError({String? msg, GlobalKey<ScaffoldState>? scaffoldState}) {
  scaffoldState!.currentState!.showBottomSheet(
    (context) => Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.red,
        child: Text(
          "$msg",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
