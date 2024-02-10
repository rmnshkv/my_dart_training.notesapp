// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Support_Screen extends StatelessWidget {
  const Support_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 192, 192, 192),
        title: Text('Поддержка',style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: 200,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail,color: const Color.fromARGB(255, 109, 109, 109),),
              SizedBox(height: 30,),
              Text('По всем вопросам просим обращаться на наш сайт',style: TextStyle(color: Colors.black),),
              Text('somesite_idk.ru',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black ),),
              Text('Раздел "Поддержка"',style: TextStyle(color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}
