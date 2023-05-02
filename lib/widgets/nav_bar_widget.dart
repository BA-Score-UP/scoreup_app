import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({
    super.key,
  });

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Provas'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.query_stats),
          label: 'Estatísticas',
        ),
      ],
    );
  }
}