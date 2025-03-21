import 'dart:io';

void main(List<String> arguments) {
  print('Enter your name: ');
  String? name = '';
  do {
    name = stdin.readLineSync();
    name = name?.trim();
  } while (name == null || name.isEmpty);
  print('Hello $name!');
}
