import 'package:flutter/material.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Group Community',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _communities = ['Community A', 'Community B', 'Community C'];
  List<String> _joinedCommunities = [];

  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _searchCommunities(String searchTerm) {
    setState(() {
      _searchResults = _communities
          .where((community) =>
              community.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Group Community'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a community',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Search for communities here
                    _searchCommunities(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // itemCount: _communities.length,
              itemCount: _searchResults.isNotEmpty
                  ? _searchResults.length
                  : _communities.length,
              itemBuilder: (context, index) {
                final community = _searchResults.isNotEmpty
                    ? _searchResults[index]
                    : _communities[index];
                // final community = _communities[index];
                return ListTile(
                  title: Text(community),
                  trailing: _joinedCommunities.contains(community)
                      ? ElevatedButton(
                          onPressed: () {
                            // Open chat page for joined community
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                    title: community, key: ValueKey(community)),
                              ),
                            );
                          },
                          child: Text('Chat'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            // Join community and open chat page
                            setState(() {
                              _joinedCommunities.add(community);
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                    title: community, key: ValueKey(community)),
                              ),
                            );
                          },
                          child: Text('Join'),
                        ),
                );
              },
            ),
          ),
         
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String title;

  ChatPage({required Key key, required this.title}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> _messages = [];

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      _messages.add(_messageController.text);
                      _messageController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}










//Sample 2

// import 'package:flutter/material.dart';

// class ChatGroupCommunity extends StatefulWidget {
//   @override
//   _ChatGroupCommunityState createState() => _ChatGroupCommunityState();
// }

// class _ChatGroupCommunityState extends State<ChatGroupCommunity> {
//   String _communityName = '';
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Group Community'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Enter Community Name',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _communityName = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Join Community'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChatPage(
//                       communityName: _communityName,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatPage extends StatefulWidget {
//   final String communityName;

//   ChatPage({required this.communityName});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<String> _messages = [];
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.communityName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_messages[index]),
//                 );
//               },
//             ),
//           ),
//           Divider(height: 1),
//           Container(
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter a message',
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_controller.text.isNotEmpty) {
//                       setState(() {
//                         _messages.add(_controller.text);
//                         _controller.clear();
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     title: 'Chat Group Community',
//     home: ChatGroupCommunity(),
//   ));
// }



//Sample 1

// import 'package:flutter/material.dart';
// class ChatPage extends StatefulWidget {
//   final String groupName;

//   ChatPage({required this.groupName});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<String> _messages = [];

//   final _controller = TextEditingController();

//   void _addMessage(String text) {
//     setState(() {
//       _messages.add(text);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.groupName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_messages[index]),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.0,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_controller.text.isNotEmpty) {
//                       _addMessage(_controller.text);
//                       _controller.clear();
//                     }
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
