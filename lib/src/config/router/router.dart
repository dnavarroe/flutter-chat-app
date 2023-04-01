
import 'package:flutter/material.dart';

import '../../presentation/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  UsersPage.routeName    : ( _ ) => const UsersPage(),
  ChatPage.routeName     : ( _ ) => const ChatPage(),
  LoginPage.routeName    : ( _ ) => const LoginPage(),
  RegisterPage.routeName : ( _ ) => const RegisterPage(),
  LoadingPage.routeName  : ( _ ) => const LoadingPage(),
};