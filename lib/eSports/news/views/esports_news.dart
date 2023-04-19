import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isLoading = true;
  List _articles = [];

  @override
  void initState() {
    super.initState();
    getNews('dota'); // Default to Dota news
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
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description']),
                  leading: Image.network(article['urlToImage']),
                  onTap: () {
                    // Open the article in a browser or WebView
                  },
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => getNews('counterstrike2'),
              child: Text('Counter'),
            ),
            ElevatedButton(
              onPressed: () => getNews('apex-legends'),
              child: Text(' Apex '),
            ),
            ElevatedButton(
              onPressed: () => getNews('Heartstone'),
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
