import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoreup_app/widgets/top_bar_widget.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Desempenho por assunto:',
              style: TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 100, 0), borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('30',style: TextStyle(fontSize: 20)),
                          Text('Bom',style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 139, 117, 0), borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('15', style: TextStyle(fontSize: 20)),
                          Text(
                            'Mediano',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 139, 0, 0), borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('8', style: TextStyle(fontSize: 20),),
                          Text('A desejar', style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              'Análise dos itens:',
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Container(
                        decoration: const BoxDecoration(color: Color.fromARGB(255, 45, 45, 45)),
                        child: Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Matéria'),
                                Text('Assunto'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Desempenho'),
                                Row(
                                  children: const [
                                    Text('50%'),
                                    Expanded(
                                      child: LinearProgressIndicator (
                                        color: Colors.green,
                                        backgroundColor: Color.fromARGB(255, 82, 82, 82),
                                        minHeight: 10,
                                        value: 0.5,
                                      ),
                                    )
                                  ],
                                ) 
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
