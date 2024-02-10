// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 192, 192, 192),
        title: Text('Политика конфиденциальности', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Тут можно что-то умное написать",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              Text(
                'Тут что-то очень умное\n'
                    "Очень-очень умное.\n"
              "И здесь",
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
              Divider(height: 30,),
              Text(
                '2. Очень важная информация',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              Text(
                'На сколько важная, что я даже не придумал',
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
              Divider(height: 30,),
              Text(
                '3. Просто заголовок',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              Text(
                '-Большая строка',
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),

              Text(
                '-Строка поменьше',
                style: TextStyle(fontSize: 12,color: Colors.black),
              ),

              Text(
                '-Очень маленькая строка жестб',
                style: TextStyle(fontSize: 10,color: Colors.black),
              ),
              Divider(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}