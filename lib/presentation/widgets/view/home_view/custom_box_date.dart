import 'package:fast_order/config/index.dart';
import 'package:flutter/material.dart';

class CustomDate extends StatelessWidget {
  final double width;
  const CustomDate({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateTime.now().toString().split(' ')[0];
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: colorList[0],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: ResponsiveText(
          text: formattedDate,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            ),
            maxFontSize: 18,
            minFontSize: 12,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ),
    );
  }
}