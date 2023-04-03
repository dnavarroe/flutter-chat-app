import 'package:chat_01/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color color;
  const CustomButtom({
    super.key, 
    this.label = '', 
    this.onPressed, 
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5)
      ),
      width: double.infinity,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 20),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.wp(5)
          ),
        ),
      ),
    );
  }
}