import 'package:intl/intl.dart';

void main() {
  List name = ['Abhay', 'Rawal'];
  List letter = [];
  name.forEach(
    (name) {
      letter.add(name.split('').first);
    },
  );
  print(letter);
  print(letter.join());

  var firstLetters = name.fold('', (previousValue, letter) => '$previousValue${letter[0]}');
  print(firstLetters);
}
