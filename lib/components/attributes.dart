import 'package:flutter/material.dart';

class BooleanAttribute extends StatelessWidget {
  final String label;
  final bool value;

  const BooleanAttribute({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: value ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
