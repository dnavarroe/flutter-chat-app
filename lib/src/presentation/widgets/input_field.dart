import 'package:chat_01/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final bool obscureText;
  final TextEditingController textController;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;
  const InputField({
    super.key, 
    this.hintText = '', 
    this.keyboardType = TextInputType.text, 
    required this.prefixIcon, 
    this.obscureText = false, 
    this.onChanged, 
    this.validator, 
    required this.textController
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0,5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        controller: textController,
        obscureText: obscureText,
        autocorrect: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: responsive.wp(3)
          )
        ),
      )
    );
  }
}