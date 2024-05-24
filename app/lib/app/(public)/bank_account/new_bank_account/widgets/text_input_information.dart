import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldInformation extends StatelessWidget {
  final String text;
  const TextFieldInformation({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(text, style: textTheme.bodyMedium),
      ],
    );
  }
}
