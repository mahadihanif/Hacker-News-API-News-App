import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;

  const DataRowWidget({super.key, 
     this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: const TextStyle(fontSize: 18),
          maxLines: 1,
          
        ),
      ],
    );
  }
}
