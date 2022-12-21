// ignore_for_file: file_names

import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:flutter/material.dart';

class DialogBuy extends StatefulWidget {
  const DialogBuy({super.key, required this.content});

  final Widget content;
  @override
  State<DialogBuy> createState() => _DialogBuyState();
}

class _DialogBuyState extends State<DialogBuy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.pink[200],
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 1 / 3,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 20,
                  child: Row(children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop((route) => route.isFirst);
                        },
                        child: const Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                        ))
                  ]),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  child: widget.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
