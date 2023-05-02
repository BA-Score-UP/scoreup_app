import 'package:flutter/material.dart';

class ContainerButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
 
  const ContainerButton({
    super.key,
    required this.title,
    required this.onPressed,
    });

  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      width: double.infinity,
      height: 120,
      child: ElevatedButton(
        onPressed: () => {widget.onPressed?.call()},
        child: Text(widget.title, 
        style: const TextStyle(fontSize: 20)
        ),
      ),
    );
  }
}