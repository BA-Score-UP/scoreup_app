import 'package:flutter/material.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(BuildContext, dynamic) builder;

  const LoadingWidget({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
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
      bottomNavigationBar: const Nav(),
    );
  }
}
