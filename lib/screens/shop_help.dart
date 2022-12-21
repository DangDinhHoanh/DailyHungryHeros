import 'package:dailyhungryheros/childcomponents/menu.dart';
import 'package:dailyhungryheros/childcomponents/shopitem.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:flutter/material.dart';

class Shop_Help extends StatefulWidget {
  const Shop_Help({super.key});

  @override
  State<Shop_Help> createState() => _Shop_HelpState();
}

class _Shop_HelpState extends State<Shop_Help> {
  var select = true;

  @override
  var lsItems = ShopItem.lsItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.orange[200],
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: lsItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(lsItems[index].image),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  'assets/icon/diamond.png',
                                ),
                              ),
                              Text(
                                lsItems[index].price.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              lsItems[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              lsItems[index].description,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
