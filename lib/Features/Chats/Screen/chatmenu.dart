import 'package:flutter/material.dart';

class ChatMenu extends StatefulWidget {
  static const String routeName = '/chat-menu';

  const ChatMenu({Key? key}) : super(key: key);

  @override
  State<ChatMenu> createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat MENU") ,centerTitle: true,backgroundColor: Colors.green, ),
      body: Container(
        child: ListView.builder(itemCount:2,itemBuilder: (context,index){
          return const Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(''), // Add your image URL here
                  backgroundColor: Colors.red,
                ),
                title: Align(
                  alignment: Alignment.centerLeft, // Adjust alignment as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "name",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                trailing: Text(
                  "20:02",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Divider(thickness: 1,color: Colors.grey,), // Add a Divider below the ListTile
              // Any additional content you want to include after the Divider
            ],
          );



        }),
      ),

    );
  }
}
