import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final String title;
  final List<String> content;
  final Function(String)? onChange;
  final bool isEnabled;

  const DropdownWidget({
    super.key,
    required this.title,
    required this.content,
    this.onChange,
    this.isEnabled = true,
  });

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          label: Text(widget.title),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        isExpanded: true,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        icon: const Icon(Icons.keyboard_arrow_down),
        value: dropdownValue,
        items: widget.content.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: widget.isEnabled ? (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onChange?.call(newValue!);
        } : null,
      ),
    );
  }
}
