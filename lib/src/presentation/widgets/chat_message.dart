import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    super.key, 
    required this.texto, 
    required this.uid, 
    required this.animationController
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
        child: Container(
          child: uid == authService.user.uid
          ? _myMessage()
          : _noMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8, left: 50, right: 5),
        decoration: BoxDecoration(
          color: const Color(0xff43CCF0).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  Widget _noMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8, left: 5, right: 50),
        decoration: BoxDecoration(
          color: const Color(0xff7DB5FA).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}