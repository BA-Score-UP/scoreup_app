import 'package:flutter/material.dart';

class BottomModal extends StatefulWidget {
  final Widget child;

  const BottomModal({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  BottomModalState createState() => BottomModalState();
}

class BottomModalState extends State<BottomModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: widget.child
      ),
    );
  }
}
