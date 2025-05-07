// LAB 1
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final _formKey = GlobalKey<FormBuilderState>(); // Додаємо ключ
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: FormBuilder(
//             key: _formKey, // Прив’язка ключа
//             child: Column(
//               children: [
//                 FormBuilderTextField(
//                   name: 'email',
//                   decoration: InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
//                         .hasMatch(value ?? '')) {
//                       return 'Невірний email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 Builder(
//                   builder: (context) => ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState?.saveAndValidate() ?? false) {
//                         print("Email: ${_formKey.currentState?.value['email']}");
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Email правильний')),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Форма не валідна')),
//                         );
//                       }
//                     },
//                     child: Text('Перевірити'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'mac',
                  decoration: InputDecoration(labelText: 'MAC-адреса'),
                  validator: (value) {
                    final macPattern = r'^([0-9A-Fa-f]{2}([-:])){5}([0-9A-Fa-f]{2})$';
                    if (!RegExp(macPattern).hasMatch(value ?? '')) {
                      return 'Невірна MAC-адреса';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        print("MAC: ${_formKey.currentState?.value['mac']}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('MAC-адреса правильна')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Форма не валідна')),
                        );
                      }
                    },
                    child: Text('Перевірити'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
