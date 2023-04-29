import 'package:flutter/material.dart';

AppBar topBar() {
  return AppBar (
    backgroundColor: Colors.white,
    title: Wrap (
      spacing: 8,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      
      children: const [
        Icon(Icons.account_circle, size: 32,),
        Text('Olá, nome!'),
      ]
    ),
    actions: [
      IconButton(
        onPressed: ()=>{},
        splashRadius: 25,
        tooltip: 'Menu',
        icon: const Icon(Icons.menu, size: 32,)
      )
    ],
  );
}