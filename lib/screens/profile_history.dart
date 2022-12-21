import 'package:dailyhungryheros/childcomponents/historyitem.dart';
import 'package:dailyhungryheros/childcomponents/menu.dart';
import 'package:flutter/material.dart';

class Profile_History extends StatefulWidget {
  const Profile_History({super.key});

  @override
  State<Profile_History> createState() => _Profile_HistoryState();
}

class _Profile_HistoryState extends State<Profile_History> {
  var lsItems = HistoryItem.lsItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.green[400],
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: lsItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: MediaQuery.of(context).size.height / 8,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/icon/rank-${lsItems[index].rank}.png',
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  child: Image.asset(
                                    lsItems[index].avatar,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  lsItems[index].name.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                const snackBar = SnackBar(
                                    content: Text('Sent a friend request'));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon: const Icon(
                                Icons.group_add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                (index % 2) == 0
                                    ? Icons.keyboard_double_arrow_up
                                    : Icons.keyboard_double_arrow_down,
                                color: (index % 2) == 0
                                    ? Color.fromARGB(255, 22, 97, 159)
                                    : Colors.red,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${lsItems[index].timeago} minius ago'),
                        ),
                      ],
                    ),
                  ],
                ));
            // Column(
            //   children: [
            //     Row(
            //       children: [

            //         Container(
            //           padding: EdgeInsets.only(right: 30),
            //           child: Image.asset(
            //             'assets/img/sasuke.png',
            //             width: 50,
            //           ),
            //         ),
            //         Container(
            //           padding: EdgeInsets.only(right: 30),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: const [
            //               Text(
            //                 'SASUKE',
            //                 style: TextStyle(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.bold),
            //               )
            //             ],
            //           ),
            //         ),
            //         Container(
            //           child: TextButton(
            //             onPressed: () {},
            //             child: Image.asset(
            //               'assets/icon/add-user.png',
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //         Container(
            //           padding: EdgeInsets.only(left: 20),
            //           child: TextButton(
            //             onPressed: () {},
            //             child: Image.asset(
            //               'assets/icon/down-arrow.png',
            //               color: Colors.red,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: const [
            //         Text(
            //           '6minus ago',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         )
            //       ],
            //     )
            //   ],
            // ));
          }),
    );
  }
}
