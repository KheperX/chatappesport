// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'package:flutter/material.dart';

class GamesCat extends StatelessWidget {
  const GamesCat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x00B42323),
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _customCliper(),
          child: Container(
            height: 190,
            width: MediaQuery.of(context).size.width - 50,
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
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 122.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // เว้นช่อง
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.all(7.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    TextSpan(
                      text: 'FPS ',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const TextSpan(text: 'Catoegory'),
                  ],
                ),
              ),
            ),

            // ค้นหา

            // เว้นช่อง
            SizedBox(height: 10),

            //------------------------------------TYPE CS2
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Image.asset(
                    'images/cs2.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width - 50,
                  ),
                ],
              ),
            ),

            // เว้นช่อง
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F1),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  // ignore: prefer_const_constructors
                  child: Text(
                    '\nName : Counter Strike 2 \n\nGenre(s)	 : Tactical first-person shooter \n\nRelease : 2023\n\nType : FPS , TEAMPLAY\n',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            //------------------------------------TYPE VAL
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Image.asset(
                    'images/val.png',
                    height: 200,
                    width: MediaQuery.of(context).size.width - 50,
                  ),
                ],
              ),
            ),

            // เว้นช่อง
            SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F1),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    '\nName : Valorant \n\nGenre(s)	 : Tactical first-person shooter \n\nRelease : 2020\n\nType : FPS , TEAMPLAY\n',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            //------------------------------------TYPE TARKOV
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Image.asset(
                    'images/tk3.jpg',
                    height: 190,
                    width: MediaQuery.of(context).size.width - 50,
                  ),
                ],
              ),
            ),

            // เว้นช่อง
            SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F1),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    '\nName : Escape From TarKov \n\nGenre(s)	 : Tactical first-person shooter \n\nRelease : 2017 (Colsed Beta)\n\nType : FPS , ADVENTURE , TEAMPLAY\n',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            //------------------------------------TYPE RON
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Image.asset(
                    'images/ron.jpg',
                    height: 200,
                    width: MediaQuery.of(context).size.width - 50,
                  ),
                ],
              ),
            ),

            // เว้นช่อง
            SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F1),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    '\nName : Ready Or Not \n\nGenre(s)	 : Tactical first-person shooter \n\nRelease : 2021 (Early Access)\n\nType : FPS , TEAMPLAY\n',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            )
          ]),
        ),
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
