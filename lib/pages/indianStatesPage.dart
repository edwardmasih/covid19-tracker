import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/datasource.dart';
import 'package:covid19_tracker/pages/search.dart';

class IndianStatePage extends StatefulWidget {
  IndianStatePage({Key key}) : super(key: key);

  @override
  IndianStatePageState createState() => IndianStatePageState();
}

class IndianStatePageState extends State<IndianStatePage> {
  Map stateData;
  fetchStateData() async {
    http.Response response = await http.get(DataSource.apiIndiaState);
    setState(() {
      stateData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    handleRefresh();
    super.initState();
  }

  Widget indianPageList() {
    return stateData['statewise'] == null
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
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              stateData['statewise'][index+1]['state'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              stateData['statewise'][index+1]['statecode'].toString(),
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
                                    stateData['statewise'][index+1]['confirmed'].toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'ACTIVE : ' +
                                    stateData['statewise'][index+1]['active'].toString(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'RECOVERED : ' +
                                    stateData['statewise'][index+1]['recovered'].toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'DEATHS : ' +
                                    stateData['statewise'][index+1]['deaths'].toString(),
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
            itemCount: stateData['statewise'] == null ? 0 : stateData['statewise'].length,
          );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statewise Stats'),
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
          stateData['statewise']== null
              ? IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: null,
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // showSearch(context: context, delegate: Search(stateData));
                    // FIX THIS
                  }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: indianPageList(),
      ),
    );
  }

  Future<void> handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    // DataSource.quote = DataSource.quote + " Refreshed" ;
    setState(() {
      print("Refreshed");
      fetchStateData();
    });
  }
}
