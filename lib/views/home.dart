import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_app2/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:web_app2/views/login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> details = [];

  getList() async {
    var response =
        await http.get(Uri.parse('https://heroapp27.herokuapp.com/get-heros/'));
    var decode = jsonDecode(response.body);

    setState(() {
      details = decode;
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
      ),
      body: ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, i) {
            return SizedBox(
              height: 200,
              child: Card(
                elevation: 100,
                shadowColor: Colors.black,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        details[i]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 80),
                      ),
                      height: 100,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(details[i]['superpower'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      height: 80,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
