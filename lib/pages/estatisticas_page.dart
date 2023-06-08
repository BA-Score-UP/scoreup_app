import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../user_provider.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/item_box_widget.dart';
import '../widgets/statistics_box_widget.dart';
import '../services/get_performance.dart';
import '../models/performance_models.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({Key? key}) : super(key: key);

  @override
  EstatisticasPageState createState() => EstatisticasPageState();
}

class EstatisticasPageState extends State<EstatisticasPage> {
  late GoogleSignInAccount user;
  late List<Map<String, dynamic>> goods;
  late List<Map<String, dynamic>> mediums;
  late List<Map<String, dynamic>> bads;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    fetchGetPerformance();
  }

  Future<void> fetchGetPerformance() async {
    final apiKey = dotenv.env['API-KEY'];
    if (apiKey == null) {
      throw Exception('API-KEY is null');
    }

    final userId = user.id;
    PerformanceModel data = await getPerformance(
      apiKey,
      userId,
    );

    setState(() {
      goods = data.getGoods();
      mediums = data.getMediums();
      bads = data.getBads();
      isLoading = false;
    });
  }

  List<List<Widget>> getContents() {
    return [
      goods.map((entry) {
        final microSubject = entry['microSubject'];
        final accuracy = entry['accuracyPercentage'];
        return ItemBox(microSubject: microSubject, percentage: accuracy);
      }).toList(),
      mediums.map((entry) {
        final microSubject = entry['microSubject'];
        final accuracy = entry['accuracyPercentage'];
        return ItemBox(microSubject: microSubject, percentage: accuracy);
      }).toList(),
      bads.map((entry) {
        final microSubject = entry['microSubject'];
        final accuracy = entry['accuracyPercentage'];
        return ItemBox(microSubject: microSubject, percentage: accuracy);
      }).toList(),
    ];
  }

  Widget? itemContent;
  List<Widget> items = const <Widget>[
    Text('Bom'),
    Text('Mediano'),
    Text('A desejar')
  ];
  List<bool> selectedItem = [false, false, false];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        endDrawer: const DrawerWidget(),
        appBar: TopBar(
          mainContent: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl!),
              radius: 16,
            ),
            Text("Olá, ${user.displayName}!"),
          ],
          isPopAble: false,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
        bottomNavigationBar: const Nav(
          index: 2,
        ),
      );
    }

    final contents = getContents();

    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: TopBar(
        mainContent: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl!),
            radius: 16,
          ),
          Text("Olá, ${user.displayName}!"),
        ],
        isPopAble: false,
      ),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatBox(
                  tile: "Bom",
                  quantity: goods.length,
                  color: Colors.green,
                ),
                StatBox(
                  tile: "Mediano",
                  quantity: mediums.length,
                  color: Colors.amberAccent,
                ),
                StatBox(
                  tile: "A desejar",
                  quantity: bads.length,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Análise dos itens:',
              style: TextStyle(fontSize: 24),
            ),
            ToggleButtons(
              borderRadius: BorderRadius.circular(8),
              isSelected: selectedItem,
              onPressed: (index) {
                setState(() {
                  for (var i = 0; i < selectedItem.length; i++) {
                    selectedItem[i] = i == index;
                  }
                  if (selectedItem[index]) {
                    itemContent = Column(
                      children: contents[index],
                    );
                  } else {
                    itemContent = null;
                  }
                });
              },
              constraints: const BoxConstraints.expand(
                height: 32,
                width: 96,
              ),
              children: items,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (itemContent != null) ...[
                      itemContent!,
                    ]
                    // Other ItemBox widgets...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(
        index: 2,
      ),
    );
  }
}
