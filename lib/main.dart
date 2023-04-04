import 'package:chat_01/src/config/router/router.dart';
import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:chat_01/src/domain/services/chat_service.dart';
import 'package:chat_01/src/domain/services/socket_service.dart';
import 'package:chat_01/src/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: LoadingPage.routeName,
        routes: appRoutes,
      ),
    );
  }
}