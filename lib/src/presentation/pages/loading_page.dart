import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:chat_01/src/domain/services/socket_service.dart';
import 'package:chat_01/src/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  static String routeName = "LoadingPage"; 
  const LoadingPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
           child: Text('Cogela suave...')
          );
        }, 
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{

    final authService = Provider.of<AuthService>(context, listen: false); 
    final socketService = Provider.of<SocketService>(context, listen: false);


    final autenticando = await authService.isLoggedIn();

    if(autenticando){
      socketService.connect();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UsersPage(),
          transitionDuration: const Duration(milliseconds: 0)
        )
      );
    }else{
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionDuration: const Duration(milliseconds: 0)
        )
      );
    }

  }
}