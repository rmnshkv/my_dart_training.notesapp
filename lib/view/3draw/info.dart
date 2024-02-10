// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 192, 192, 192),
        title: Text('Важная информация', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Анекдот',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              Text(
                'Hа стpойку собиpается приехать комиссия. Пpоpаб инстpуктиpует pабочих: — Что бы ни случилось, делайте вид, что так и должно быть. Комиссия пpиехала, осматpивает. Вдpуг pухнула одна стена. Рабочий, pадостно посмотpев на часы: — Десять тpидцать пять. Точно по гpафику!',
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
              Divider(height: 30,),
               Text(
                '2. Цитата',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              Text(
                'Без подошвы тапочки - это просто тряпочки.',
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
                            Text(
                'Джейсон Стетхем (c)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Divider(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
