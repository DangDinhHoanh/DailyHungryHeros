import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/childcomponents/answer.dart';
import 'package:dailyhungryheros/model/question.dart';
import 'package:dailyhungryheros/screens/dialogbuy.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:dailyhungryheros/screens/profile.dart';
import 'package:dailyhungryheros/screens/result.dart';
import 'package:dailyhungryheros/screens/result_dual.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DualScreen extends StatefulWidget {
  DualScreen({
    super.key,
    required this.lsQuestions,
  });

  List<Question> lsQuestions;

  @override
  State<DualScreen> createState() => _DualScreenState();
}

class _DualScreenState extends State<DualScreen> {
  late int time = 45;

  int diamond = 1024;
  
  void runTime() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          time--;
          if (time == 0) {
            timer.cancel();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultDual(result: result),
                ),
                (route) => false);
          }
        });
    });
  }

  late PageController _controller;

  var questionIndex = 1;
  late bool lock = false;
  List<int> select = [];

  int result = 0;
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
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                      width:
                          (MediaQuery.of(context).size.width - 20) * time / 45,
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
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
      ),
    );
  }

  Container buildQuestion(Question question) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 210, 97),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  question.question,
                  textScaleFactor: 1.2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Answer(
              question: question,
              lock: lock,
              select: select,
              onClick: ((value) {
                if (value == question.correct) {
                  setState(() {
                    result++;
                  });
                }
                if (questionIndex < widget.lsQuestions.length) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.bounceInOut);
                  setState(() {
                    questionIndex++;
                  });
                } else {
                  Navigator.pop(context);
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
