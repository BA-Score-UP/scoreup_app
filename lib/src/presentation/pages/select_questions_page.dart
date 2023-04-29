import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scoreup_app/src/presentation/widgets/nav_bar_widget.dart';
import 'package:scoreup_app/src/presentation/widgets/top_bar_widget.dart';

class SelectQuestions extends StatefulWidget {
  const SelectQuestions({super.key});

  @override
  State<SelectQuestions> createState() => _SelectQuestionsState();
}

class _SelectQuestionsState extends State<SelectQuestions> {

  String? _dropdownvalue;

  var items = [
    'Matemática',
    'Português',
    'Inglês',
    'Fisica',
    'Biologia',
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          spacing: 20,
          runSpacing: 30,
          children: [
            SizedBox(
              width: 280,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Selecione a matéria'),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                ),            
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: const Text(
                  'Matéria', 
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _dropdownvalue,
                items: items.map((String items){
                  return DropdownMenuItem(
                    value: items, 
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownvalue = newValue!;
                  });
                }
              ),
            ),
            SizedBox(
              width: 280,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Selecione o assunto'),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                ),                  
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: const Text(
                  'Assunto', 
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _dropdownvalue,
                items: items.map((String items){
                  return DropdownMenuItem(
                    value: items, 
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownvalue = newValue!;
                  });
                }
              ),
            ),
            SizedBox(
              width: 280,
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Selecione a quantidade de questões'),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                ),                  
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: const Text(
                  'Quantidade de questões', 
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _dropdownvalue,
                items: items.map((String items){
                  return DropdownMenuItem(
                    value: items, 
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownvalue = newValue!;
                  });
                }
              ),
            ),
            SizedBox(
              width: 280,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900)), 
                child: const Text(
                  'Selecionar', 
                style: TextStyle(
                  color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Nav(),
    );
  }
}