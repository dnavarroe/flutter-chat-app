

import 'package:chat_01/src/domain/global/environment.dart';
import 'package:chat_01/src/domain/models/users_response.dart';
import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat_01/src/domain/models/user.dart';

class UsersService {

  Future<List<User>> getUsers() async {

    try {
      
      final url = Uri.parse('${Enviroment.apiUrl}/usuarios');
      final res = await http.get(url, headers: {
      'Content-Type':'application/json',
      'x-token': await AuthService.getToken()
      });

      final usersResponse = usersResponseFromJson(res.body);

      return usersResponse.usuarios;

    } catch (e) {
      return [];
    }
  }
}