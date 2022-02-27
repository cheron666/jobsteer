// ignore_for_file: sized_box_for_whitespace, unnecessary_string_interpolations, prefer_const_constructors, avoid_print, unused_local_variable, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:jobsteer/colors.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageDecoration getPageDecoration() => const PageDecoration(
        fullScreen: true,
        // imagePadding: EdgeInsets.fromLTRB(40, 40, 40, 0),
        pageColor: Color(0xff212426),
      );
  Widget _buildImage(String path) {
    return Center(child: Image.asset(path, height: 350, width: 350));
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
  // String _parseHtmlString(String htmlString) {
  //   final document = parse(htmlString);

  //   return document.
  // }

  Future getWeather() async {
    var api = "b0c04c24-66b6-40da-aca8-2cf5c4d94cdd";
    String title;

    // Uri url = Uri.parse(
    //     "http://api.openweathermap.org/data/2.5/weather?q=england&units=imperial&appid=$api");
    // http.Request request = http.Request("get", url);
    // request.headers.clear();
    // request.headers.addAll({"content-type": "application-json"});
    // http.Response response = await request.send();
    // var results = jsonDecode(response.body);

    http.Response response = await http.post(
        Uri.parse(
            "https://jooble.org/api/b0c04c24-66b6-40da-aca8-2cf5c4d94cdd"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"keywords": "flutter", "location": "India"}));
    var results = jsonDecode(response.body);

    setState(() {
      title = removeAllHtmlTags(results['jobs'][0]['title']);
      print(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    String starter = 'Welcome';
    var _index = 0;
    var textlist = ['Welcome', 'Bye', 'GG', 'Hmm'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                // margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kBackground,
                    borderRadius: BorderRadius.circular(20),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 15,
                          offset: Offset(6, 6),
                          color: Color(0XFF424242)),
                      BoxShadow(
                          offset: Offset(-6, -6),
                          color: Color(0xff000000),
                          blurRadius: 15,
                          spreadRadius: 1.0)
                    ]),
                height: size.height * 0.55,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntroductionScreen(
                      // ignore: prefer_const_constructors
                      dotsDecorator: DotsDecorator(
                          color: const Color(0xffC4C4C4),
                          activeColor: const Color(0xffEF43A7)),
                      globalBackgroundColor: kBackground,
                      // dotsDecorator: DotsDecorator( ``),
                      showSkipButton: false,
                      showNextButton: false,
                      showBackButton: false,
                      showDoneButton: false,
                      onChange: (index) => setState(() {
                            starter = textlist[index];
                          }),
                      pages: [
                        PageViewModel(
                          decoration: getPageDecoration(),
                          title: '  ',
                          body: '  ',
                          image: _buildImage(
                            "assets/images/first.jpg",
                          ),
                        ),
                        PageViewModel(
                          decoration: getPageDecoration(),
                          title: '  ',
                          body: '  ',
                          image: _buildImage(
                            "assets/images/second.jpg",
                          ),
                        ),
                        PageViewModel(
                          decoration: getPageDecoration(),
                          title: '  ',
                          body: '  ',
                          image: _buildImage(
                            "assets/images/third.jpg",
                          ),
                        ),
                        PageViewModel(
                          decoration: getPageDecoration(),
                          title: '  ',
                          body: '  ',
                          image: _buildImage(
                            "assets/images/fourth.jpg",
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Container(
              height: size.height * 0.45,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "pay your credit card bills. win rewards.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'GilroyBold',
                      letterSpacing: 0.006,
                      fontSize: 24,
                      color: Color(
                        0xffCFD0D0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffEF43A7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text("Continue",
                          style: TextStyle(
                              fontFamily: 'GilroyBold', fontSize: 16)),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "Get Data",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      print("Hello world");
                      getWeather();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
