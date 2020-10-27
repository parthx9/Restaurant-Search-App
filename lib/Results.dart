import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final List _restaurants;

  Results(this._restaurants);
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return widget._restaurants == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 118,
                color: Colors.black12,
              ),
              Text(
                'No Results To Display',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black12),
              )
            ],
          )
        : Expanded(
            child: ListView(
                children: widget._restaurants
                    .map((restaurant) => ListTile(
                          title: Text(restaurant['restaurant']['name']),
                          subtitle: Text(
                              restaurant['restaurant']['location']['address']),
                          trailing: Text(
                              '${restaurant['restaurant']['user_rating']['aggregate_rating']} stars, '
                              '${restaurant['restaurant']['all_reviews_count']}'),
                        ))
                    .toList()));
  }
}
