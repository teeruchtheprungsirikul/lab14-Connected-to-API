import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  String data;
  WelcomeScreen({ Key? key, required this.data }) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    print(widget.data);
    print(token);
    if (widget.data  != '') {
      Map<String, dynamic> map = jsonDecode(widget.data);
      token = map['token'];
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Your token : ' + token,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await homeAPI(token).then((res) {
                    _showDialog(context, res.body);
                  });
                }, 
                child: const Text('Connect Home with token')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await specialAPI(token).then((res) {
                    _showDialog(context, res.body);
                  });
                }, 
                child: const Text('Connect Special with token')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.data = '';
                    token = '';
                  });
                }, 
                child: const Text('Clear token'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

    void _showDialog(BuildContext context, String msg) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(""),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"), 
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
  }

   Future<http.Response> homeAPI(String token) async {
    //var url = "http://localhost:3000/api/user/login";
    var url = "http://10.0.2.2:3000/api/home";
    var response = await http.get(Uri.parse(url), headers: {"auth-token": token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  Future<http.Response> specialAPI(String token) async {
    //var url = "http://localhost:3000/api/user/login";
    var url = "http://10.0.2.2:3000/api/user/special";
    var response = await http.get(Uri.parse(url), headers: {"Authorization": 'Bearer ' + token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }
}