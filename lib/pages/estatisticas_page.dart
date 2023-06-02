import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../user_provider.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({ Key? key }) : super(key: key);

  @override
  EstatisticasPageState createState() => EstatisticasPageState();
}

class EstatisticasPageState extends State<EstatisticasPage> {
  late GoogleSignInAccount user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: TopBar(
        mainContent: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl!),
            radius: 16,
          ),
          Text("Olá, ${user.displayName}!")
        ],
        isPopAble: false,
      ),
      bottomNavigationBar: const Nav(index: 2,),
    );
  }
}