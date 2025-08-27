import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.onTap,
    this.titleStyle,
  });

  final Widget leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chevron = Icon(CupertinoIcons.right_chevron,
        size: 18, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(
          title,
          style: titleStyle ?? theme.textTheme.titleMedium,
        ),
        subtitle: subtitle == null
            ? null
            : Text(
          subtitle!,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: chevron,
      ),
    );
  }
}