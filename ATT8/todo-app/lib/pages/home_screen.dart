import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/posts_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home, color: Colors.red),
              title: Text("Home"),
              subtitle: Text("Tela Inicial"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.red),
              title: Text("Checklist"),
              subtitle: Text("Checklist e dark theme"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.red),
              title: Text("Posts"),
              subtitle: Text("Tela de Post"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostPage()));
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Text('Conteúdo da tela inicial'),
      ),
    );
  }
}
