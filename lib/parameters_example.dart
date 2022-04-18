import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const ParametersGoogleCloudFunctionExample());


class ParametersGoogleCloudFunctionExample extends StatefulWidget {
  const ParametersGoogleCloudFunctionExample({Key? key}) : super(key: key);

  @override
  _ParametersGoogleCloudFunctionExampleState createState() => _ParametersGoogleCloudFunctionExampleState();
}

class _ParametersGoogleCloudFunctionExampleState extends State<ParametersGoogleCloudFunctionExample> {
  late Future<String> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = callCloudFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Cloud Function - basic',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Cloud Function - basic'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<String> callCloudFunction() async {
  final response = await http.post(Uri.parse('insert your url here'),
      body: jsonEncode(<String, String>{
        'name': 'Bart',
      }));

  // request with url parameters
  // final response = await http
  //     .get(Uri.parse('insert your url here?name=Bart'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to call function');
  }
}
