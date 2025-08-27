import 'package:flutter/material.dart';

class LearnMore extends StatelessWidget {
  const LearnMore({super.key,
    required this.isDark,
    this.onTap,
  });

  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final base = isDark ? Colors.white : Colors.black;

    final iconColor = base.withOpacity(0.35);
    final textColor = base.withOpacity(0.70);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.front_hand_outlined,
            size: 40,
            color: iconColor,
          ),
          const SizedBox(height: 8),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap ?? () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Learn more about us',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.north_east,
                    size: 16,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}