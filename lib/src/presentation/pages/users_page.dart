import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  static String routeName = "userPage";
  const UsersPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('UserPages'),
      ),
    );
  }
}