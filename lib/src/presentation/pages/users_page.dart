import 'package:chat_01/src/domain/models/user.dart';
import 'package:chat_01/src/domain/services/auth_service.dart';
import 'package:chat_01/src/domain/services/chat_service.dart';
import 'package:chat_01/src/domain/services/socket_service.dart';
import 'package:chat_01/src/domain/services/users_services.dart';
import 'package:chat_01/src/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static String routeName = "userPage";
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  final usersService = UsersService();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<User> usersdb = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user.username,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 1,
        backgroundColor: const Color(0xff7DB5FA),
        leading: IconButton(
          onPressed: (){

            socketService.disconnect();
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
            AuthService.deleteToken();

          }, 
          icon: const Icon(Icons.exit_to_app_outlined, color: Colors.black,)
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus==ServerStatus.Online)
            ?Icon(Icons.check_circle, color: Colors.green[100],)
            :const Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: const WaterDropMaterialHeader(
          distance: 30,
          backgroundColor: Color(0xff7DB5FA),
        ),
        child: _listViewUsers(),
      )
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userListTile(usersdb[i]), 
      separatorBuilder: (_, i) => const Divider(), 
      itemCount: usersdb.length
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
        title: Text(user.username),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          backgroundColor: Colors.indigo[100],
          child: Text(user.username.substring(0,1)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
          color: user.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userPara = user;
          Navigator.pushNamed(context, ChatPage.routeName);
        },
      );
  }

  _loadUsers() async {
    
    usersdb = await usersService.getUsers();
    setState(() {
      
    });
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }
}