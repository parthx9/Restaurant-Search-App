import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  Function onSearch;

  SearchForm(this.onSearch);
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formkey = GlobalKey<FormState>();
  var _searchterm;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefix: Icon(Icons.search),
                    hintText: 'Enter Search',
                    border: OutlineInputBorder(),
                    filled: true,
                    errorStyle: TextStyle(fontSize: 16),
                  ),
                  onChanged: (value) {
                    _searchterm = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter A Search Term';
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.red,
                        onPressed: () {
                          final isValid = _formkey.currentState.validate();
                          if (isValid) {
                            widget.onSearch(_searchterm);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ))))
          ],
        ));
  }
}
