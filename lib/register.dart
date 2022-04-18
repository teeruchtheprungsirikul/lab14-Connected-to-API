import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:lab14/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีผู้ใช้')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ชื่อ', style: TextStyle(fontSize: 20)),
                TextFormField(
                  validator: RequiredValidator(errorText: 'กรุณาป้อนชื่อ'),
                  controller: name,
                ),
                const SizedBox(height: 15),
                const Text('อีเมล',style: TextStyle(fontSize: 20)),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'กรุณาป้อนอีเมล'),
                    EmailValidator(errorText: 'รูปแบบอีเมลไม่ถูกต้อง')
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                ),
                const SizedBox(height: 15),
                const Text('รหัสผ่าน', style: TextStyle(fontSize: 20)),
                TextFormField(
                  obscureText: true,
                  validator: 
                    RequiredValidator(errorText: 'กรุณาป้อนรหัสผ่าน'),
                    controller: password,
                ),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton.icon(
                   onPressed: (() async {
                     if (formKey.currentState!.validate()) {
                       formKey.currentState!.save();
                       await registerAPI(name.text, email.text, password.text)
                          .then((res) {
                        if (res.statusCode == 200) {
                          _showDialog(context, "บันทึกเรียบร้อย");
                        } else {
                          _showDialog(context, res.body);
                        }
                      });
                     }
                   }), 
                   icon: const Icon(Icons.app_registration_rounded), 
                   label: const Text(
                     'ลงทะเบียน',
                     style: TextStyle(fontSize: 20),
                   )))
              ],
            ),
          )),
      ));
  }

   Future<http.Response> registerAPI(String? name, String? email, String? password) async {
    //var url = "http://localhost:3000/api/user/login";
    var url = "http://10.0.2.2:3000/api/user/register";
    var body = {'name': name,'email': email, 'password':password};

    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json"}, body: json.encode(body));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
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
                Navigator.pushReplacement(context, 
                    MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                    })
                );
              }
            ),
          ],
        );
      }
    );
  }
}