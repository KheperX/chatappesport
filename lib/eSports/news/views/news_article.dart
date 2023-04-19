// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class NewsArticle {
//   String title;
//   String content;

//   NewsArticle({required this.title, required this.content});
// }

// class NewsScreen2 extends StatefulWidget {
//   @override
//   _NewsScreen2State createState() => _NewsScreen2State();
// }

// class _NewsScreen2State extends State<NewsScreen2> {
//   bool _isLoading = true;
//   List _articles = [];

//   @override
//   void initState() {
//     super.initState();
//     getNews('dota'); // Default to Dota news
//   }

//   Future<void> getNews(String category) async {
//     setState(() {
//       _isLoading = true;
//     });
//     final apiKey = '321c605cc20b4af2992aaa64e2e88e90';
//     final url =
//         'https://newsapi.org/v2/everything?q=${category}&apiKey=${apiKey}';
//     final response = await http.get(Uri.parse(url));
//     final jsonData = json.decode(response.body);
//     setState(() {
//       _isLoading = false;
//       _articles = jsonData['articles'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('News'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _articles.length,
//               itemBuilder: (context, index) {
//                 final article = _articles[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => NewsTitleScreen(
//                           title: article['title'],
//                           content: article['content'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     title: Text(article['title']),
//                     subtitle: Text(article['description']),
//                     leading: Image.network(article['urlToImage']),
//                   ),
//                 );
//               },
//             ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () => getNews('fortnite'),
//               child: Text('Fortnite'),
//             ),
//             ElevatedButton(
//               onPressed: () => getNews('apex-legends'),
//               child: Text(' Apex Legend '),
//             ),
//             ElevatedButton(
//               onPressed: () => getNews('pokemon'),
//               child: Text('Pokemon'),
//             ),
//             ElevatedButton(
//               onPressed: () => getNews('pubg'),
//               child: Text('PUBG'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NewsTitleScreen extends StatelessWidget {
//   final String title;
//   final String content;

//   NewsTitleScreen({required this.title, required this.content});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//             content,
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsArticle {
  String title;
  String content;

  NewsArticle({required this.title, required this.content});
}

class NewsScreen2 extends StatefulWidget {
  @override
  _NewsScreen2State createState() => _NewsScreen2State();
}

class _NewsScreen2State extends State<NewsScreen2> {
  bool _isLoading = true;
  List _articles = [];

  @override
  void initState() {
    super.initState();
    getNews('gaming'); // Default to Dota news
  }

  Future<void> getNews(String category) async {
    setState(() {
      _isLoading = true;
    });
    final apiKey = '321c605cc20b4af2992aaa64e2e88e90';
    final url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=${apiKey}';
    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);
    setState(() {
      _isLoading = false;
      _articles = jsonData['articles'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                final article = _articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsTitleScreen(
                          title: article['title'],
                          content: article['content'],
                          imageUrl: article['imageUrl'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(article['title']),
                    subtitle: Text(article['description']),
                    leading: Image.network(article['urlToImage']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsTitleScreen(
                            title: article['title'],
                            content: article['content'],
                            imageUrl: article['urlToImage'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => getNews('fortnite'),
              child: Text('Fortnite'),
            ),
            ElevatedButton(
              onPressed: () => getNews('apex-legends'),
              child: Text(' Apex Legend '),
            ),
            ElevatedButton(
              onPressed: () => getNews('heartstone'),
              child: Text('Heartstone'),
            ),
            ElevatedButton(
              onPressed: () => getNews('pubg'),
              child: Text('PUBG'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsTitleScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  NewsTitleScreen(
      {required this.title, required this.content, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(imageUrl),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                content,
                style: TextStyle(fontSize: 16.0),
                maxLines: null,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
