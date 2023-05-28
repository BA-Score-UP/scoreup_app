import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({
    Key? key,
  }) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _currentIndex = 1; // Keep track of the selected index

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });

    // Perform navigation based on the selected index
    switch (index) {
      case 0:
        // Navigate to Provas page
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ProvasPage()));
        break;
      case 1:
        // Navigate to Home page
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 2:
        // Navigate to Estatísticas page
        // Navigator.push(context, MaterialPageRoute(builder: (context) => EstatisticasPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      onTap: _onItemTapped, // Set the onTap callback
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Provas',
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
