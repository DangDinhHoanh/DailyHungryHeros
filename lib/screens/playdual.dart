import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/loadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

class PlayDual extends StatefulWidget {
  const PlayDual({Key? key}) : super(key: key);

  @override
  State<PlayDual> createState() => _PlayDualState();
}

class _PlayDualState extends State<PlayDual> {
  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  int time = 0;
  bool ishas = false;
  bool isfind = false;

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  late Timer timer;
  void runTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (mounted) {
        if (isfind) {
          setState(() {
            time++;
          });
          await getMatch();
        } else {
          timer.cancel();
        }
      }

      if (ishas) {
        LengthQuestion().then((value) async {
          await firestore
              .collection('questions')
              .where('id',
                  isGreaterThanOrEqualTo: (Random().nextDouble() * l).floor())
              .limit(90)
              .get()
              .then((v) {
            final questionDocs = v.docs;

            lsQuestions = questionDocs
                .map((e) => Question.fromQueryDocumentSnapshot(e))
                .toList();
          }).then((m) {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) => Loadding(
                  list: lsQuestions,
                ),
              ),
            );
          });
        });
      }
    });
  }

  String uid1 = '';
  String uid2 = '';
  String nickname1 = '';
  String nickname2 = '';
  int roomid = -1;

  List<Question> lsQuestions = [];

  int count = 0;

  Future getName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.uid)
        .get()
        .then((value) {
      uid1 = auth.uid;
      nickname1 = value.get('nickname');
    });
  }

  Future getMatch() async {
    await FirebaseFirestore.instance
        .collection('matches')
        .doc(roomid.toString())
        .get()
        .then((value) {
      uid1 = auth.uid;
      if (uid1 == value.get('user1')[0]) {
        uid2 = value.get('user2')[0];
        nickname1 = value.get('user1')[1];
        nickname2 = value.get('user2')[1];
      } else {
        uid2 = value.get('user1')[0];
        nickname1 = value.get('user2')[1];
        nickname2 = value.get('user1')[1];
      }
    });
    if (uid2 != '') {
      setState(() {
        ishas = true;
        timer.cancel();
      });
    }
  }

  int l = 0;
  Future LengthQuestion() async {
    final authUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('questions')
        .get()
        .then((value) => setState(() {
              l = value.docs.length;
            }));
  }

  @override
  void initState() {
    super.initState();
    getName().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [

              SizedBox(
                child: ishas
                    ? Image.asset(
                        'assets/img/vs.gif',
                      )
                    : Image.asset(
                        'assets/img/pk.png',
                      ),
              ),
              isfind
                  ? Container()
                  : Center(
                      child: GestureDetector(
                        onTap: () async {
                          await firestore
                              .collection('counters')
                              .doc('wait')
                              .get()
                              .then(
                            (value) {
                              if (value.exists) {
                                roomid = value.get('counter');
                                firestore
                                    .collection('counters')
                                    .doc('wait')
                                    .set({'counter': roomid + 1});
                                if (roomid % 2 == 0) {
                                  firestore
                                      .collection('matches')
                                      .doc((roomid).toString())
                                      .set({
                                    'user1': [
                                      auth.uid,
                                      nickname1,
                                      0,
                                    ],
                                    'user2': [
                                      '',
                                      '',
                                      0,
                                    ],
                                  });
                                } else {
                                  roomid -= 1;
                                  firestore
                                      .collection('matches')
                                      .doc((roomid).toString())
                                      .update({
                                    'user2': [
                                      auth.uid,
                                      nickname1,
                                      0,
                                    ],
                                  });
                                  setState(() {
                                    ishas = true;
                                  });
                                }
                              }
                            },
                          );
                          setState(() {
                            isfind = true;
                          });
                          runTime();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 5,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.width / 2.5,
                          alignment: AlignmentDirectional.bottomCenter,
                        ),
                      ),
                    )
            ],
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              if (isfind) {
                setState(() {
                  isfind = false;
                  time = 0;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Image.asset(
                'assets/icon/back.png',
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
