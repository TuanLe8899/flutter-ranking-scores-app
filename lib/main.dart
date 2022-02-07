// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? scoreMathController;
  TextEditingController? scoreLiteratureController;
  TextEditingController? scoreEnglishController;
  String avgScore = "Chưa xác định";
  String rank = "Chưa xác định";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scoreMathController = TextEditingController();
    scoreLiteratureController = TextEditingController();
    scoreEnglishController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scoreMathController!.dispose();
    scoreLiteratureController!.dispose();
    scoreEnglishController!.dispose();
  }

  String ranking({required double avgScore}) {
    if(avgScore < 3) rank = "Kém";
    else if(avgScore >=3 && avgScore < 5) rank = "Yếu";
    else if(avgScore >=5 && avgScore < 7.5) rank = "Trung bình";
    else if(avgScore >= 7.5 && avgScore < 8) rank = "Khá";
    else if(avgScore >= 8 && avgScore <= 9) rank = "Giỏi";
    else rank = "Xuất sắc";
    return rank;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            textInputWidget(
              labelText: "Điểm Toán",
              hintText: "Nhập điểm môn Toán",
              controller: scoreMathController,
            ),
            textInputWidget(
              labelText: "Điểm Văn",
              hintText: "Nhập điểm môn Văn",
              controller: scoreLiteratureController,
            ),
            textInputWidget(
              labelText: "Điểm Anh",
              hintText: "Nhập điểm môn Anh",
              controller: scoreEnglishController,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  avgScore = ((double.parse(scoreMathController!.text) +
                              double.parse(scoreLiteratureController!.text) +
                              double.parse(scoreEnglishController!.text)) /
                          3)
                      .toString();
                  rank = ranking(avgScore: double.parse(avgScore));
                });
              },
              child: const Text("Xác Nhận"),
            ),
            informationCard(avgScore: avgScore, rank: rank),
          ],
        ),
      ),
    );
  }

  Widget textInputWidget(
      {required String labelText,
      required String hintText,
      required controller}) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }

  Widget informationCard({required String avgScore, required String rank}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          color: Colors.amber,
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                const Text(
                  "Thông tin",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Text("Điểm trung bình: $avgScore"),
                Text("Xếp hạng: $rank"),
              ],
            ),
          )),
    );
  }
}
