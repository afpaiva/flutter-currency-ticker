import 'package:flutter/material.dart';

Widget DisplayResults(
    {required apiResult, required selectedBaseSymbol, required label}) {
  return Card(
    color: Colors.lightBlueAccent,
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
      child: Text(
        '1 $label = $apiResult $selectedBaseSymbol',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    ),
  );
}
