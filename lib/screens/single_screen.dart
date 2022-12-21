import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/childcomponents/answer.dart';
import 'package:dailyhungryheros/model/question.dart';
import 'package:dailyhungryheros/screens/dialogbuy.dart';
import 'package:dailyhungryheros/screens/profile.dart';
import 'package:dailyhungryheros/screens/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleScreen extends StatefulWidget {
  SingleScreen(
      {super.key,
      required this.level,
      required this.lsQuestions,
      required this.heart});

  final int level;
  final int heart;
  List<Question> lsQuestions;

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  late int time = 0;

  int diamond = 1024;

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  // Future getHeart() async {
  //   final us = FirebaseAuth.instance.currentUser!;

  //   final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
  //   final user = await userRef.get();
  //   final doc = user.data();
  //   heart = doc!['heart'];
  // }

  void runTime() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          time++;
        });
    });
  }

  late int heart = widget.heart;

  late PageController _controller;

  var questionIndex = 1;
  late bool lock = false;
  List<int> select = [];

  int score = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      runTime();
    });
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: Container(
          padding: const EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Color.fromARGB(255, 11, 52, 86),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Icon(
                  Icons.timer_sharp,
                  size: 25,
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                  child: Text(
                    formatedTime(timeInSecond: time).toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: heart,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Image(
                        image: const AssetImage('assets/icon/heart.png'),
                        width: MediaQuery.of(context).size.height / 30,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ],
            )
          ]),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.lsQuestions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final question = widget.lsQuestions[index];
                return buildQuestion(question);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 11,
        decoration: BoxDecoration(
          border: const Border(top: BorderSide(color: Colors.white, width: 2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Color.fromARGB(255, 11, 52, 86),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image(
                    image: const AssetImage('assets/icon/ask.png'),
                    width: MediaQuery.of(context).size.height / 20,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image(
                    image: const AssetImage('assets/icon/50-50.png'),
                    width: MediaQuery.of(context).size.height / 20,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image(
                    image: const AssetImage('assets/icon/pass.png'),
                    width: MediaQuery.of(context).size.height / 20,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
