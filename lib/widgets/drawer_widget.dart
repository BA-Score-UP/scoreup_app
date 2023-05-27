import 'package:flutter/material.dart';
import '../api/google_signin_api.dart';
import '../pages/login_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({ Key? key }) : super(key: key);

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  double horizontalPadding = 16;
  double verticalPadding = 32;

  Future logout() async {
    await GoogleSignInAPI.logout();
    handleLogout();
  }

  void handleLogout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.fromLTRB (
          horizontalPadding,
          verticalPadding,
          horizontalPadding,
          verticalPadding
        ),
        child: Expanded (
          child: Column (
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(  
                width: double.infinity,
                height: 40,
                child: ElevatedButton (
                  onPressed: () => logout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red[300],
                    )
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}