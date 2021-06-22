import 'package:belajar_bloc/ui/list_user/list_user.dart';
import 'package:belajar_bloc/ui/list_user_cubit/list_user_cubit.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              child: Text("List User Bloc"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListUserPage()));
              },
            ),
            MaterialButton(
              child: Text("List User Cubit"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListUserCubit()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
