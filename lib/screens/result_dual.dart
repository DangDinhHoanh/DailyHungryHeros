// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/model/highscore.dart';
import 'package:dailyhungryheros/model/level.dart';
import 'package:dailyhungryheros/screens/level.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';
import 'single_screen.dart';

class ResultDual extends StatefulWidget {
  ResultDual({
    Key? key,
    required this.result,
  }) : super(key: key);

  final int result;

  @override
  State<ResultDual> createState() => _ResultDualState();
}

class _ResultDualState extends State<ResultDual> {
  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;
  String nickname = '';
  int rank = 0;

  Future getUser() async {
    await firestore.collection('users').doc(auth.uid).get().then((value) {
      nickname = value.get('nickname');
      // rank = value.get('rank');
    });
  }

  Future update() async {
    int match = 0;

    await firestore.collection('counters').doc('wait').get().then((value) {
      match = value.get('counter') - 2;
    });
    final doc = await firestore.collection('matches').doc(match.toString());
    doc.get().then((value) {
      if (auth.uid == value.get('user1')[0]) {
        var ls = value.get('user1');
        ls[2] = widget.result;
        doc.update({
          'user1': ls
        });
      } else {
        var ls = value.get('user2');
        ls[2] = widget.result;
        doc.update({
          'user2': ls
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    update().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(202, 45, 5, 1),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: widget.result > 3
                            ? Image.asset('assets/img/win.webp')
                            : Image.asset('assets/img/lose.webp'),
                      ),
                      Text(nickname)
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(3, 178, 217, 1),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
