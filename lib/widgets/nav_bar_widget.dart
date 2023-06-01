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
      currentIndex: 1,
      selectedItemColor: const Color.fromARGB(255, 41, 224, 175),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16
      ),
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontSize: 14
      ),
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