import 'package:flutter/material.dart';

AppBar topBar() {
  return AppBar (
    title: const Wrap (
      spacing: 8,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Icon(Icons.account_circle, size: 32,),
        Text('Olá, nome!'),
      ]
    ),
    actions: [
      IconButton(
        onPressed: ()=>{},
        icon: const Icon(Icons.menu, size: 32,)
      )
    ],
  );
}