import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _articles = [];
  bool _isLoading = false;

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
    });

    // final response = await http.get(Uri.parse(
    //     'https://newsapi.org/v2/top-headlines?country=us&apiKey=321c605cc20b4af2992aaa64e2e88e90'));
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=esports-event&apiKey=321c605cc20b4af2992aaa64e2e88e90'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      setState(() {
        _articles = body['articles'];
        _isLoading = false;
      });
    } else {
      print('Failed to fetch news articles: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNews();
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
    );
  }
}
