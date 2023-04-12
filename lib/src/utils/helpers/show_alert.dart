import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle){
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Column(
        children: [
          Image.asset(
            "assets/luff.png",
            width: 340,
            height: 140,
          ),
          Text(title),
        ],
      ),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.black,
          onPressed: ()=>Navigator.pop(context),
          child: const Text("Ok")
        )
      ],
    ),
  );
}