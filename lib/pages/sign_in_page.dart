import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/sign_in_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key
  });

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: image
            ),
            const Text(
              "Bem Vindo ao ScoreUP!",
              style: TextStyle (
                fontSize: 32
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 64),
                padding: EdgeInsets.zero, // Remove padding to align label and icon
              ),
              onPressed: signIn,
              child: const Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text("Sign In with Google"), 
                  Icon(Icons.login_rounded),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
