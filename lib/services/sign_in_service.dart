import '../api/google_sign_in_api.dart';

Future signIn() async{
  await GoogleSignInApi.login();
}