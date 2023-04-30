import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final String title;
  final List<String> content;
  final Function()? onChange;
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
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
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
        value: _dropdownValue,
        items: widget.content.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: widget.isEnabled ? (String? newValue) {
          setState(() {
            _dropdownValue = newValue!;
          });
          widget.onChange?.call();
        } : null,
      ),
    );
  }
}
