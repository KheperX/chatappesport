// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'package:app/eSports/reccomend/views/GameCatModel.dart';
import 'package:flutter/material.dart';

import 'Aboutgame.dart';
import 'GamesCat.dart';
import 'GamesCat2.dart';
import 'GamesCat3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class GamesRec extends StatefulWidget {
  const GamesRec({super.key});

  @override
  State<GamesRec> createState() => _GamesRecState();

  static void add(GamesRec model) {}
}

class _GamesRecState extends State<GamesRec> {
  List<GameCatModel> gamecatData = [];
  List<GameCatModel> itemListOnSearch = [];
  TextEditingController? _valueContains = TextEditingController();

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("Initialize Success");
      var x = await FirebaseFirestore.instance
          .collection('game_cat')
          .orderBy('title')
          .get();
      x.docs.forEach((element) {
        print(element.data());
        GameCatModel model = GameCatModel.fromMap(element.data());
        gamecatData.add(model);
      });

      Future.delayed(Duration(seconds: 2));
      itemListOnSearch = gamecatData;
      setState(() {}); //rebuild line 42 after readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x00B42323),
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _customCliper(),
          child: Container(
            height: 195,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF19202d),
            child: Center(
              child: Text(
                'Games Category',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
            ),
          ),
        ),
        toolbarHeight: 125,
      ),
      // extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ค้นหา
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                border: Border.all(color: Color.fromARGB(255, 17, 44, 56)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Search'),
                  controller: _valueContains,
                  onChanged: (value) {
                    setState(() {
                      itemListOnSearch = gamecatData
                          .where((element) => element.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
            ),
          ),

          // เว้นช่อง
          SizedBox(height: 25),

          // หมวดหมู่1
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GamesCat()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFCE3038),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('FPS',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
              ),

              // หมวดหมู่2
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFFCE3038),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'TEAMPLAY',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamesCat2()));
                  }),

              // หมวดหมู่3
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFFCE3038),
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'ADVENTURE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamesCat3()));
                  }),

              // หมวดหมู่4
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xFFCE3038),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Text(
                      'MOBA',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // เว้นช่อง
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(7.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline6,
                children: [
                  TextSpan(
                    text: 'Recommend ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const TextSpan(text: 'For You !'),
                ],
              ),
            ),
          ),

          // เว้นช่อง
          SizedBox(height: 3),

          ListView.builder(
            shrinkWrap: true,
            itemCount: itemListOnSearch.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: InkWell(
                    child: Image.network(
                      itemListOnSearch[index].image_url,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutGame(),
                        ),
                      );
                    }),
              );
            },
          ),

          SizedBox(height: 50),

          Center(
            child: Text(
              "Check More in ' Games Category ' ",
              style: TextStyle(
                color: Color.fromARGB(255, 132, 136, 143),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          // เว้นช่อง
          SizedBox(height: 5),
          Center(
            child: Text(
              "Updated 20/04/2023 ",
              style: TextStyle(
                color: Color.fromARGB(255, 132, 136, 143),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(height: 50),
        ]),
      ),
    );
  }
}

class _customCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();

    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
