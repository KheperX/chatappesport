import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Group Chat App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Group Chat App'),
//     );
//   }
// }

class NewChatGroup extends StatefulWidget {
  NewChatGroup({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewChatGroupState createState() => _NewChatGroupState();
}

class _NewChatGroupState extends State<NewChatGroup> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<GroupChat> groupChats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Community')
          // title: Text(widget.title),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 320,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                ),
              ),
            ),
            SizedBox(
              width: 320,
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  groupChats.add(
                    GroupChat(
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  );
                  titleController.clear();
                  descriptionController.clear();
                });
              },
              child: Text('Create Group Chat'),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 95,
        height: 85,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(groupChats: groupChats),
              ),
            );
          },
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 6,
            shape: CircleBorder(),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         SizedBox(
    //           width: 320,
    //           child: TextField(
    //             controller: titleController,
    //             decoration: InputDecoration(
    //               hintText: 'Enter Title',
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           width: 320,
    //           child: TextField(
    //             controller: descriptionController,
    //             decoration: InputDecoration(
    //               hintText: 'Enter Description',
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 35,
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             setState(() {
    //               groupChats.add(
    //                 GroupChat(
    //                   title: titleController.text,
    //                   description: descriptionController.text,
    //                 ),
    //               );
    //               titleController.clear();
    //               descriptionController.clear();
    //             });
    //           },
    //           child: Text('Create Group Chat'),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: Container(
    //     width: 100,
    //     height: 100,
    //     child: FloatingActionButton(
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => SearchPage(groupChats: groupChats)),
    //         );
    //       },
    //       tooltip: 'Join Group Chat',
    //       child: Text(
    //         'Search',
    //         style: TextStyle(
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       // child: Icon(Icons.search),
    //     ),
    //   ),
    // );
  }
}

class GroupChat {
  final String title;
  final String description;

  GroupChat({required this.title, required this.description});
}

class SearchPage extends StatelessWidget {
  final List<GroupChat> groupChats;

  SearchPage({required this.groupChats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search and Join Group Chat'),
      ),
      body: ListView.builder(
        itemCount: groupChats.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(groupChats[index].title),
            subtitle: Text(groupChats[index].description),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatPage(groupChat: groupChats[index])),
                );
              },
              child: Text('Join'),
            ),
          );
        },
      ),
    );
  }
}

//Sample 1

// class ChatPage extends StatelessWidget {
//   final GroupChat groupChat;

//   ChatPage({required this.groupChat});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(groupChat.title),
//       ),
//       body: Center(
//         child: Text('Chat with people in the ${groupChat.title} group chat'),
//       ),
//     );
//   }
// }

//Sample 2

// class ChatPage extends StatefulWidget {
//   final GroupChat groupChat;

//   ChatPage({required this.groupChat});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController messageController = TextEditingController();
//   List<String> messages = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.groupChat.title),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(messages[index]),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type your message...',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       messages.add(messageController.text);
//                       messageController.clear();
//                     });
//                   },
//                   child: Text('Send'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Sample 3
class ChatPage extends StatefulWidget {
  final GroupChat groupChat;

  ChatPage({required this.groupChat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    // Load the saved messages when the chat page is initialized
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      messages = prefs.getStringList(widget.groupChat.title) ?? [];
    });
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(widget.groupChat.title, messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupChat.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      messages.add(messageController.text);
                      messageController.clear();
                      _saveMessages(); // Save the messages after sending
                    });
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
