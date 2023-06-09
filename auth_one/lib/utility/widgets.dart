import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
    {required String hintText, required IconData icon}) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: const Color.fromRGBO(50, 52, 72, 1.0)),
    hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}

MaterialButton longButtons(String title, void Function() onPressed,
    {Color color = Colors.blue, Color textColor = Colors.white}) {
  return MaterialButton(
    onPressed: onPressed,
    textColor: textColor,
    color: color,
    height: 45,
    minWidth: 600,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.center,
        )),
  );
}
