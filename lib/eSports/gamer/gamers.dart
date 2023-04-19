import 'package:app/eSports/gamer/gamer_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'gamers_model.dart';

class Gamers extends StatefulWidget {
  const Gamers({Key? key}) : super(key: key);

  @override
  State<Gamers> createState() => _GamersState();
}

class _GamersState extends State<Gamers> {
  //SearchBar
  TextEditingController? _valueContains = TextEditingController();
  //SearchList
  List<GamersModel> itemListOnSearch = [];

  List<GamersModel> gamersData = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("Initialize Success");
      var x = await FirebaseFirestore.instance
          .collection('proplayers')
          .orderBy('game')
          .get();
      x.docs.forEach((element) {
        print(element.data());
        print(element.id);

        GamersModel model = GamersModel.fromMap(element.data(), element.id);
        gamersData.add(model);
      });

      Future.delayed(Duration(seconds: 2));
      itemListOnSearch = gamersData;
      setState(() {}); //rebuild line 42 after readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(gamersData);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(24)),
          child: TextField(
            onChanged: (value) {
              setState(() {
                itemListOnSearch = gamersData
                    .where((element) => element.game
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
            controller: _valueContains,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search',
              //
            ),
          ),
        ),
      ),
      body: itemListOnSearch.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamerProfile(
                                id: gamersData[index].id,
                              )),
                    );
                  },
                  child: Card(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 100,
                            child: Image.network(
                                itemListOnSearch[index].image_url),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // Text(
                          //   itemListOnSearch[index].id,
                          //   style: const TextStyle(
                          //       fontSize: 16, fontWeight: FontWeight.bold),
                          // ),
                          // const SizedBox(
                          //   height: 6,
                          // ),
                          Text(
                            itemListOnSearch[index].name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            itemListOnSearch[index].game,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            itemListOnSearch[index].experience,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            itemListOnSearch[index].phone,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            itemListOnSearch[index].email,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    //child: Text(sponsorsData[index].company),
                  ),
                );
              },
              itemCount: itemListOnSearch.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3),
            ),
    );
  }
}
