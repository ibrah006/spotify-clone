import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String label;

  const RadioButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5).copyWith(right: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: theme.textTheme.titleLarge!.color!.withAlpha(30)),
      child: Text(
        label,
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}
