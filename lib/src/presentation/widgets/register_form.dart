import 'package:chat_01/src/presentation/widgets/custombutton.dart';
import 'package:chat_01/src/presentation/widgets/input_field.dart';
import 'package:chat_01/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final userCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTable?430:responsive.wp(86),
        ),
        width: double.infinity,
        height: responsive.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(
               prefixIcon: const Icon(Icons.person,),
               hintText: 'USERNAME',
               textController: userCtrl,
            ),
            SizedBox(height: responsive.hp(3)),
            InputField(
               prefixIcon: const Icon(Icons.mail_outline,),
               hintText: 'EMAIL ADDRESS',
               keyboardType: TextInputType.emailAddress,
               textController: emailCtrl,
            ),
            SizedBox(height: responsive.hp(3)),
            InputField(
              prefixIcon: const Icon(Icons.key_rounded),
              hintText: 'PASSWORD',
              obscureText: true,
              textController: passCtrl,
            ),
            SizedBox(height: responsive.hp(5)),
            CustomButtom(label: 'Sign Up', onPressed: () {}),
            SizedBox(height: responsive.hp(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do you already have an account?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: responsive.wp(4),
                  ),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: responsive.wp(4),
                      color: const Color(0xff5361E0)
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: responsive.hp(20),),
          ],
        ),
      ),
    );
  }
}