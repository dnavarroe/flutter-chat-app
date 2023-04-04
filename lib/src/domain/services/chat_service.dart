import 'package:chat_01/src/domain/global/environment.dart';
import 'package:chat_01/src/domain/models/mensajes_response.dart';
import 'package:chat_01/src/domain/models/user.dart';
import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier{

  late User userPara;

  Future<List<Mensaje>> getChat(String userID)async{

    final url = Uri.parse('${Enviroment.apiUrl}/mensajes/$userID');

    final resp = await http.get(url, headers: {
      'Content-Type':'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajeResp = mensajesResponseFromJson(resp.body);

    return mensajeResp.mensajes;

  }

  
}