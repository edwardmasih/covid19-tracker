import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/datasource.dart';
import 'package:covid19_tracker/pages/search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  
  List countryData;
  fetchcountryData() async {
    http.Response response =
        await http.get(DataSource.apiCountry + "?sort=cases");
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    handleRefresh();
    // print(countryData.length);
    super.initState();
  }

  Widget countryPageList() {
    return countryData == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              countryData[index]['country'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              countryData[index]['countryInfo']['flag'],
                              height: 50,
                              width: 60,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'CONFIRMED : ' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ACTIVE : ' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'RECOVERED : ' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'DEATHS : ' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    color:
                                        DynamicTheme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey
                                            : Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: countryData == null ? 0 : countryData.length,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Stats'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.lightbulb_outline
                    : Icons.highlight,
              ),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light,
                );
              }),
          countryData == null
              ? IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: null,
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: Search(countryData));
                  }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: countryPageList(),
      ),
    );
  }

  Future<void> handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    // DataSource.quote = DataSource.quote + " Refreshed" ;
    setState(() {
      print("Refreshed");
      fetchcountryData();
    });
  }
}
