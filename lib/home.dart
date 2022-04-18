import 'package:flutter/material.dart';
import 'package:lab14/login.dart';
import 'package:lab14/register.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children:[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                      }));
                  }
                ),
                icon: const Icon(Icons.login),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                label: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(fontSize: 20),
                ))),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const RegisterScreen();
                        })
                    );
                  }, 
                  icon: const Icon(Icons.app_registration_outlined),
                  style: ElevatedButton.styleFrom(primary: Colors.orange), 
                  label: const Text(
                    'สร้างบัญชีใหม่',
                    style: TextStyle(fontSize: 20),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}