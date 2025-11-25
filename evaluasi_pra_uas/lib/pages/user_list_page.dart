import 'package:flutter/material.dart';
import '../services/user_services.dart';
import '../models/user_model.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<UserModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService.fetchUsers();
  }

  void refreshData() {
    setState(() {
      futureUsers = UserService.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pengguna"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshData,
          )
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Gagal memuat data"));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final u = users[index];
              return ListTile(
                title: Text(u.name),
                subtitle: Text("${u.email}\nKota: ${u.city}"),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
