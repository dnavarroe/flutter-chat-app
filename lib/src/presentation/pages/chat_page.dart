import 'dart:io';

import 'package:chat_01/src/presentation/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static String routeName = "chatPage";
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _message = [];

  bool _writing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDAE4F2),
      appBar: AppBar(
        elevation: 1,
        leading: const Icon(Icons.arrow_back_outlined),
        backgroundColor: const Color(0xff7DB5FA),
        title: Row(
          children: const [
            CircleAvatar(
              child: Text('DN'),
            ),
            SizedBox(width: 10,),
            Text('Daniel Navarro')
          ],
        ),
        actions: [

          IconButton(onPressed: (){}, icon: const Icon(Icons.video_camera_front_rounded)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.phone)),
          
        ],
      ),
      body: Container(
        child: Column(
          children: [

            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: (_, i) => _message[i],
                reverse: true,
              )
            ),
            Divider(height: 1),
            //TODO: Caja de texto
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( String texto ){

                  setState(() {
                    if(texto.trim().length>0){
                      _writing = true;
                    }else{
                      _writing = false;
                    }
                  });

                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send message',
                  border: InputBorder.none
                ),
                focusNode: _focusNode,
              )
            ),

            // Send Buton
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
              ? CupertinoButton(
                // ignore: sort_child_properties_last
                child: const Text('Send'), 
                onPressed: _writing
                  ? () => _handleSubmit(_textController.text.trim())
                  : null,
              )

              : Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: IconTheme(
                  data: const IconThemeData(color: Color(0xff7DB5FA)),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.send_rounded),
                    onPressed: _writing
                      ? () => _handleSubmit(_textController.text.trim())
                      : null, 
                  ),
                ),
              )
            )
          ],
        ),
      )
    );

  }

  _handleSubmit (String texto) {

    if(texto.length==0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto, 
      uid: '123',
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _message.insert(0,newMessage);
    newMessage.animationController.forward();
    setState(() {
      _writing = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket
    for( ChatMessage message in _message){
      message.animationController.dispose();
    }
    super.dispose();
  }
}