import 'package:flutter/material.dart';
import 'name_form.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Форма Ім\'я')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NameForm(),
      ),
    ),
  ));
}
