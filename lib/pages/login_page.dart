import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/home_page.dart';
import '../services/set_user.dart';
import '../api/google_signin_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key
  });

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {

  Future signIn() async {
    var user = await GoogleSignInAPI.login();

    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    await setUser(
      apiKey,
      user!.id
    );

    handleLogin(user);
  }

  void handleLogin(user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage(account: user))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/app_logo.svg"
            ),
            const Text(
              "Bem vindo ao ScoreUP!",
              style: TextStyle(fontSize: 32),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 64),
                padding: EdgeInsets.zero,
              ),
              onPressed: signIn,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("SignIn with Google"),
                  SizedBox(width: 8),
                  Icon(Icons.login_rounded),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}