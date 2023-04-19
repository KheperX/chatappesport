import 'package:flutter/material.dart';
import 'display.dart';
import 'formscreen.dart';

class DataHome extends StatefulWidget {
  const DataHome({super.key});

  @override
  State<DataHome> createState() => _DataHomeState();
}

class _DataHomeState extends State<DataHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [FormScreen(), DisplayScreen()],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              text: "บันทึกคะแนนสอบ",
            ),
            Tab(
              text: "รายชื่อนักเรียน",
            )
          ],
        ),
      ),
    );
  }
}
