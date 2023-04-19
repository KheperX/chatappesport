import 'package:app/eSports/sponsor/sponsors_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Sponsors extends StatefulWidget {
  const Sponsors({super.key});

  @override
  State<Sponsors> createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  //SearchBar
  TextEditingController? _valueContains = TextEditingController();
  //SearchList
  List<SponsorsModel> itemListOnSearch = [];

  List<SponsorsModel> sponsorsData = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("Initialize Success");
      var x = await FirebaseFirestore.instance
          .collection('sponsors')
          .orderBy('company')
          .get();
      x.docs.forEach((element) {
        print(element.data());
        SponsorsModel model = SponsorsModel.fromMap(element.data());
        sponsorsData.add(model);
      });

      Future.delayed(Duration(seconds: 2));
      itemListOnSearch = sponsorsData;
      setState(() {}); //rebuild line 42 after readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(sponsorsData);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(24)),
          child: TextField(
            onChanged: (value) {
              setState(() {
                itemListOnSearch = sponsorsData
                    .where((element) => element.company
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
                return Card(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          child:
                              Image.network(itemListOnSearch[index].image_url),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          itemListOnSearch[index].company,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          itemListOnSearch[index].phone,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          itemListOnSearch[index].email,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  //child: Text(sponsorsData[index].company),
                );
              },
              itemCount: itemListOnSearch.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   print(sponsorsData);
//   return Scaffold(
//     body: sponsorsData.length == 0
//         ? Center(child: CircularProgressIndicator())
//         : GridView.builder(
//             itemBuilder: (context, index) {
//               return Card(
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 100,
//                         child: Image.network(sponsorsData[index].image_url),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         sponsorsData[index].company,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         sponsorsData[index].phone,
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         sponsorsData[index].email,
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //child: Text(sponsorsData[index].company),
//               );
//             },
//             itemCount: sponsorsData.length,
//             gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           ),
//   );
// }
