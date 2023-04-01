import 'package:chat_01/src/presentation/widgets/login_form.dart';
import 'package:chat_01/src/presentation/widgets/formas.dart';
import 'package:chat_01/src/presentation/widgets/icon_container.dart';
import 'package:chat_01/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "LoginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
        color: const Color(0xffDAE4F2),
        height: responsive.height,
        width: double.infinity,
        child: Stack(
          children: [
            const TopForm(),
            const BotForm(),
            Positioned(
                top: responsive.hp(11),
                left: responsive.wp(40),
                child: IconContainer(
                  size: responsive.wp(20),
                )
            ),
            Positioned(
              left: responsive.wp(7),
              top: responsive.hp(15),
              child: const LoginForm()
            ),
          ],
        ),
          ),
      ));
  }
}






