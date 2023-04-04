import 'dart:io';

import 'package:chat_01/src/domain/models/mensajes_response.dart';
import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:chat_01/src/domain/services/chat_service.dart';
import 'package:chat_01/src/domain/services/socket_service.dart';
import 'package:chat_01/src/presentation/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  static String routeName = "chatPage";
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final List<ChatMessage> _message = [];

  bool _writing = false;

  @override
  void initState() {
    super.initState();

    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(chatService.userPara.uid);
  }

  void _cargarHistorial(String userID) async{

    List<Mensaje> chat = await chatService.getChat(userID);
    
    final history = chat.map((m) => ChatMessage(
      texto: m.mensaje, 
      uid: m.de, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 0))..forward()
      )
    );

    setState(() {
      _message.insertAll(0, history);
    });

  }

  void _escucharMensaje(dynamic payload){
    ChatMessage message = ChatMessage(
      texto: payload['mensaje'], 
      uid: payload['de'], 
      animationController: AnimationController(vsync: this,duration: Duration(milliseconds: 300))
    );
    setState(() {
      _message.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final userPara = chatService.userPara;
    
    return Scaffold(
      backgroundColor: const Color(0xffDAE4F2),
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_outlined)
        ),
        backgroundColor: const Color(0xff7DB5FA),
        title: Row(
          children: [
            CircleAvatar(
              child: Text(userPara.username.substring(0,2)),
            ),
            const SizedBox(width: 10,),
            Text(userPara.username)
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
            const Divider(height: 1),
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

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto, 
      uid: authService.user.uid,
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 200)),
    );
    _message.insert(0,newMessage);
    newMessage.animationController.forward();
    setState(() {
      _writing = false;
      socketService.emit('mensaje-personal',{
        'de':authService.user.uid,
        'para':chatService.userPara.uid,
        'mensaje':texto
      });
    });
  }

  @override
  void dispose() {
    for( ChatMessage message in _message){
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}