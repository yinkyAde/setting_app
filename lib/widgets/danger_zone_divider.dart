import 'package:flutter/material.dart';

class DangerZoneDivider extends StatelessWidget {
  const DangerZoneDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = Divider(color: Theme.of(context).dividerColor, height: 32);
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w700,
    );

    return Row(
      children: [
        Expanded(child: divider),
        const SizedBox(width: 8),
        const Icon(
          Icons.warning_amber_rounded,
          size: 18,
          color: Colors.amber,
        ),
        const SizedBox(width: 6),
        Text('Danger zone', style: textStyle),
        const SizedBox(width: 8),
        Expanded(child: divider),
      ],
    );
  }
}