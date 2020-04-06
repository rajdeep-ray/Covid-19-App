import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDetail extends StatefulWidget {
  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  String url = 'https://api.rootnet.in/covid19-in/stats/latest';
  var data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      data = jsonDecode(response.body);
    });
    return "";
  }

  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Indian States",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Text(
                    "\nLoading..",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        title: Text(
          "Indian States",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
          ),
          ListView.builder(
            itemCount: data == null ? 0 : data['data']['regional'].length,
            itemBuilder: (BuildContext context, i) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        data['data']['regional'][i]['loc'],
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Total Confirmed Cases : ${int.parse(data['data']['regional'][i]['confirmedCasesIndian'].toString()) + int.parse(data['data']['regional'][i]['confirmedCasesForeign'].toString())}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                              "Confirmed Cases (Indian) : ${data['data']['regional'][i]['confirmedCasesIndian'].toString()}"),
                          Text(
                              "Confirmed cases (Foreign) : ${data['data']['regional'][i]['confirmedCasesForeign'].toString()}"),
                          Text(
                              "Discharged : ${data['data']['regional'][i]['discharged'].toString()}"),
                          Text(
                              "Deaths : ${data['data']['regional'][i]['deaths'].toString()}"),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyDetailGlobal extends StatefulWidget {
  @override
  _MyDetailGlobalState createState() => _MyDetailGlobalState();
}

class _MyDetailGlobalState extends State<MyDetailGlobal> {
  String url = 'https://covid2019-api.herokuapp.com/v2/current';
  var data;
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      data = jsonDecode(response.body);
    });
    return "";
  }

  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Text(
                    "\nLoading..",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Go Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data == null ? 0 : data['data'].length,
                    itemBuilder: (BuildContext context, i) {
                      print(i);
                      return Card(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                data['data'][i]['location'].toString(),
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Confirmed Cases : ${data['data'][i]['confirmed'].toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                      "Deaths : ${data['data'][i]['deaths'].toString()}")
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}