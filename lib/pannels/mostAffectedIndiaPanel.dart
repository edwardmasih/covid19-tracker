import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class MostAffectedIndiaPanel extends StatelessWidget {
  final Map stateData;

  const MostAffectedIndiaPanel({Key key, this.stateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                        'Last Updated Time : ' +
                            stateData['statewise'][0]['lastupdatedtime']
                                .toString(),
                        style: TextStyle(color: Colors.green[600], fontSize: 12)),
                    
                  ],
                ),
                SizedBox(height:5),
                Row(
                  children: <Widget>[
                    Text(
                      stateData['statewise'][0]['state'].toString(),
                    ),
                    SizedBox(width: 10),
                    Text(
                        'Confirmed: ' +
                            stateData['statewise'][0]['confirmed'].toString(),
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                    SizedBox(width: 10),
                    Text(
                        'Active: ' +
                            stateData['statewise'][0]['active'].toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                    SizedBox(width: 10),
                    Text(
                      'Deaths: ' +
                          stateData['statewise'][0]['deaths'].toString(),
                      style: TextStyle(
                          color: DynamicTheme.of(context).brightness ==
                                  Brightness.dark
                              ? Colors.grey
                              : Colors.grey[600],
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          ListView.builder(
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      child: Text(
                        stateData['statewise'][index + 1]['state'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              'Active: ' +
                                  stateData['statewise'][index + 1]['active']
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Deaths: ' +
                                stateData['statewise'][index + 1]['deaths']
                                    .toString(),
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 6,
          ),
        ],
      ),
    );
  }
}
