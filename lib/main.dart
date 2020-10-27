import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import 'SearchForm.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(RestaurantSearchApp());
}

class RestaurantSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      home: SearchPage(title: 'Restaurant App'),
    );
  }
}

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final dio = Dio(BaseOptions(
      baseUrl: 'https://developers.zomato.com/api/v2.1/search',
      headers: {'user-key': DotEnv().env['API_KEY']}));
  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _restaurants;

  void restaurantsearch(String query) async {
    final response = await widget.dio.get('', queryParameters: {
      'q': query,
    });
    setState(() {
      _restaurants = response.data['restaurants'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchForm(restaurantsearch),
            SizedBox(
              height: 20,
            ),
            _restaurants == null
                ? Expanded(
                    child: Column(
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
                    ),
                  )
                : Expanded(
                    child: ListView(
                        children: _restaurants
                            .map((restaurant) => ListTile(
                                  title: Text(restaurant['restaurant']['name']),
                                  subtitle: Text(restaurant['restaurant']
                                      ['location']['address']),
                                  trailing: Text(
                                      '${restaurant['restaurant']['user_rating']['aggregate_rating']} stars, '
                                      '${restaurant['restaurant']['all_reviews_count']}'),
                                ))
                            .toList()))
          ],
        ),
      ),
    );
  }
}
