import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(BuildContext, dynamic) builder;
  final bool secondary;

  const LoadingWidget({
    super.key,
    required this.future, 
    required this.builder,
    this.secondary = true
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondary? const TopBar() : null,
      body: Center(
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Exibe o widget de loading enquanto busca os dados
              return CircularProgressIndicator(
                color: Colors.blue.shade900,
              );
            } else if (snapshot.hasError) {
              // Trata erros, se houver
              return Text('Ocorreu um erro: ${snapshot.error}');
            } else {
              // Quando os dados estiverem prontos, exibe a próxima página
              return builder(context, snapshot.data);
            }
          },
        ),
      ),
      bottomNavigationBar: secondary? const Nav() : null,
    );
  }
}
