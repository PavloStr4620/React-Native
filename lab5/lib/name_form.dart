import 'package:flutter/material.dart';

String formatFullName(String firstName, String lastName) {
  return 'Привіт, $firstName $lastName!';
}


class NameForm extends StatefulWidget {
  @override
  _NameFormState createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String message = '';

  void handleSubmit() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    setState(() {
      message = formatFullName(firstName, lastName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: Key('firstNameField'),
          controller: firstNameController,
          decoration: InputDecoration(labelText: 'Ім’я'),
        ),
        TextField(
          key: Key('lastNameField'),
          controller: lastNameController,
          decoration: InputDecoration(labelText: 'Прізвище'),
        ),
        ElevatedButton(
          key: Key('submitButton'),
          onPressed: handleSubmit,
          child: Text('Підтвердити'),
        ),
        Text(message, key: Key('greetingText')),
      ],
    );
  }
}
