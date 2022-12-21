import 'package:dailyhungryheros/screens/login.dart';
import 'package:dailyhungryheros/screens/register.dart';
import 'package:dailyhungryheros/screens/resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:bottom_drawer/bottom_drawer.dart';

class GetCode extends StatefulWidget {
  const GetCode({super.key});

  @override
  State<GetCode> createState() => _GetCodeState();
}

class _GetCodeState extends State<GetCode> {
  TextEditingController username = TextEditingController();

  TextEditingController newpass = TextEditingController();

  BottomDrawerController _controller = BottomDrawerController();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/img/loginbackground.gif',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 70,
                    alignment: AlignmentDirectional.center,
                    child: DropShadow(
                      blurRadius: 5,
                      offset: const Offset(5, 5),
                      spread: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/logo.png',
                            width: MediaQuery.of(context).size.width / 1.5,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: const EdgeInsets.all(40),
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: TextField(
                                  controller: username,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.account_circle_sharp,
                                      color: Colors.black45,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.5),
                                    focusColor: Colors.brown,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      gapPadding: 5.0,
                                    ),
                                    hintText: 'Username',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: TextField(
                                  onChanged: (value) =>
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ResetPass()),
                                          (route) => false),
                                  controller: username,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.code_rounded,
                                      color: Colors.black45,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.refresh_rounded),
                                      onPressed: () {},
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.5),
                                    focusColor: Colors.brown,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      gapPadding: 5.0,
                                    ),
                                    hintText: 'OTP',
                                  ),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.brown),
                                        ),
                                        onPressed: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: const Text(
                                            'Get code',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        '3 s',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          BottomDrawer(
            header: Container(
              alignment: AlignmentDirectional.topCenter,
              width: MediaQuery.of(context).size.width,
            ),
            body: Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false),
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Sign in again',
                        style: TextStyle(
                          color: Color.fromARGB(255, 96, 69, 59),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                        (route) => false),
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 96, 69, 59),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            headerHeight: 0,
            drawerHeight: 170,
            color: Colors.white.withOpacity(0.5),
            controller: _controller,
          ),
          Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      status = !status;
                      return status ? _controller.open() : _controller.close();
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
