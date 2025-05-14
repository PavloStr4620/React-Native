import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/name_form.dart';

void main() {
  test('Formats full name correctly', () {
    expect(formatFullName('Іван', 'Петренко'), 'Привіт, Іван Петренко!');
    expect(formatFullName('Анна', 'Ковальчук'), 'Привіт, Анна Ковальчук!');
  });
}

