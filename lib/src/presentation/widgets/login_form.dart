import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:chat_01/src/presentation/pages/pages.dart';
import 'package:chat_01/src/presentation/widgets/custombutton.dart';
import 'package:chat_01/src/presentation/widgets/input_field.dart';
import 'package:chat_01/src/utils/helpers/show_alert.dart';
import 'package:chat_01/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
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
            CustomButtom(
              color: authService.authenticating ? Colors.grey:Color(0xff43CCF0),
              label: 'Sign In', 
              onPressed: authService.authenticating ? null :() async{

                FocusScope.of(context).unfocus();

                final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                if(loginOk){
                  //navegar otra pantalla
                  Navigator.pushReplacementNamed(context, UsersPage.routeName);
                }else{
                  //Mostrar alerta
                  showAlert(context, 'Login Invalid', 'Revisar credenciales');
                }

              }
            ),
            SizedBox(height: responsive.hp(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New to Friendly Desi?',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: responsive.wp(4),
                  ),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  child: Text(
                    'Sign up',
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