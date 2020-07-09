import 'dart:convert';

import 'package:covid19_tracker/datasource.dart';
import 'package:covid19_tracker/pages/indianStatesPage.dart';
import 'package:covid19_tracker/pannels/infoPanel.dart';
import 'package:covid19_tracker/pannels/mostAffectedIndiaPanel.dart';
import 'package:covid19_tracker/pannels/mostAffectedPanel.dart';
import 'package:covid19_tracker/pannels/worldwidePanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/pages/countryPage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future  handleRefresh() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   setState(() {
  //     print("Refreshed");
  //     fetchWorldwideData();
  //     fetchcountryData();
  //     fetchStateData();
  //   });
  // }

  Future fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    fetchWorldwideData();
    fetchcountryData();
    fetchStateData();
    print('AYE AYEDE TERE BAAP KI SHAADI HAI KYA RE');
  }

  Map worldData;
  fetchWorldwideData() async {
    http.Response response = await http.get(DataSource.api);
    setState(() {
      worldData = json.decode(response.body);
      //print(worldData);
    });
  }

  List countryData;
  fetchcountryData() async {
    http.Response response =
        await http.get(DataSource.apiCountry + "?sort=deaths");
    setState(() {
      countryData = json.decode(response.body);
      // print(countryData);
    });
  }

  Map stateData;
  fetchStateData() async {
    http.Response response = await http.get(DataSource.apiIndiaState);
    setState(() {
      stateData = json.decode(response.body);
      //print(stateData);
    });
  }

  @override
  void initState() {
    // fetchWorldwideData();
    // fetchcountryData();
    // fetchStateData();
    fetchData();
    super.initState();
  }

  Widget mainPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            height: 100,
            color: Colors.orange[100],
            child: Text(
              DataSource.quote,
              //"Nothing in life is to be feared. It is only to be understood. Now is the time to understand more, so that we may fear less.",
              style: TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Worldwide',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Circular',
                    fontSize: 22,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (contect) => CountryPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          DynamicTheme.of(context).brightness == Brightness.dark
                              ? darkThemeBlack
                              : primaryBlack,
                      borderRadius: BorderRadius.all(Radius.elliptical(5, 10)),
                    ),
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Circular',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IndianStatePage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          DynamicTheme.of(context).brightness == Brightness.dark
                              ? darkThemeBlack
                              : primaryBlack,
                      borderRadius: BorderRadius.all(Radius.elliptical(5, 10)),
                    ),
                    child: Text(
                      'Indian States',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Circular',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //calling fetchWorldwideData() here
          worldData == null
              ? Center(child: CircularProgressIndicator())
              : WorldwidePanel(worldData: worldData),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Most Affected Countries',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
                fontSize: 20,
              ),
            ),
          ),
          countryData == null
              ? LinearProgressIndicator()
              : MostAffectedPanel(countryData: countryData),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Most Affected States in India',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 5),
          stateData['statewise'] == null
              ? LinearProgressIndicator()
              : MostAffectedIndiaPanel(stateData: stateData),

          SizedBox(height: 20),
          InfoPanel(),

          SizedBox(height: 40),
          Center(
            child: Text(
              "WE ARE TOGETHER IN THE FIGHT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'COVID-19 TRACKER',
        ),
        actions: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: GestureDetector(
          //     onTap: () {
          //       DynamicTheme.of(context).setBrightness(
          //         Theme.of(context).brightness == Brightness.light
          //             ? Brightness.dark
          //             : Brightness.light,
          //       );
          //     },
          //     child: Image.asset(
          //       'icons/moon.png',
          //       color: Colors.white,
          //       scale: 0.5,
          //     ),
          //   ),
          // ),
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.lightbulb_outline
                : Icons.highlight),
            onPressed: () {
              DynamicTheme.of(context).setBrightness(
                Theme.of(context).brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light,
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: mainPage(),
      ),
    );
  }
}