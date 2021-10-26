import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  _ExampleFormState createState() => _ExampleFormState();
}

class _ExampleFormState extends State<SearchPage> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> formData;
  List<String> products = [
    'Mustard Oil',
    'Sabji Masala',
    'Lal Mirchi Powder',
    'Garam Masala',
    'Haldi Powder',
    'Wild Honey',
    'Dhaniya Powder',
    'Sugarcane Vinegar',
  ];
  // List<String> countries = [
  //   'INDIA',
  //   'USA',
  //   'JAPAN',
  // ];

  _ExampleFormState() {
    formData = {
      'Product': 'Mustard Oil',
    };
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buildFutures(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            default:
              if (snapshot.hasError) {
                // return Text(snapshot.error.toString());
                return Text("Please enter something to search!");
              } else {
                if (snapshot.data != null)
                  return Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        titleSpacing: 5.0,
                        title: Center(
                          child: Text(
                            'Search Your Choice:',
                            style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        actions: <Widget>[
                          Builder(
                            builder: (BuildContext context) {
                              return IconButton(
                                  icon: const Icon(Icons.check, color: Colors.green,),
                                  iconSize: 24.0,
                                  tooltip: 'Save',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _formKey.currentState!.save();
                                      showDialog<String>(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) =>
                                              AlertDialog(
                                                content: Text(
                                                    'Data submitted is \n${formData.toString()}'),
                                              ));
                                    }
                                  });
                            },
                          )
                        ],
                      ),
                      body: Container(
                        color: Colors.white,
                        constraints: BoxConstraints.expand(),
                        child: Form(
                            key: _formKey,
                            autovalidate: false,
                            child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    // Divider(
                                    //     height: 10.0,
                                    //     color: Theme.of(context).primaryColor),
                                    SizedBox(height: 12.0,),
                                    DropDownField(
                                        value: formData['Product'],
                                        icon: Icon(Icons.store),
                                        required: true,
                                        hintText: 'Choose a product',
                                        labelText: 'Product*',
                                        items: products,
                                        strict: false,
                                        setter: (dynamic newValue) {
                                          formData['Product'] = newValue;
                                        }),
                                    // Divider(
                                    //     height: 10.0,
                                    //     color: Theme.of(context).primaryColor),
                                    // DropDownField(
                                    //     value: formData['Country'],
                                    //     icon: Icon(Icons.map),
                                    //     required: false,
                                    //     hintText: 'Choose a country',
                                    //     labelText: 'Country',
                                    //     items: countries,
                                    //     setter: (dynamic newValue) {
                                    //       formData['Country'] = newValue;
                                    //     }),
                                  ],
                                ))),
                      ));
                else
                  return LinearProgressIndicator();
              }
          }
        });
  }

  Future<bool> buildFutures() async {
    return true;
  }
}
