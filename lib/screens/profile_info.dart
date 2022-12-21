import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:dailyhungryheros/screens/shop.dart';
import 'package:flutter/material.dart';

class Profile_Info extends StatefulWidget {
  const Profile_Info({super.key});

  @override
  State<Profile_Info> createState() => _Profile_InfoState();
}

class _Profile_InfoState extends State<Profile_Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.green[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      margin: const EdgeInsets.all(10),
                      alignment: AlignmentDirectional.center,
                      child: Image.asset(
                        'assets/icon/rank-5.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 50,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]
        ));
  }
}
