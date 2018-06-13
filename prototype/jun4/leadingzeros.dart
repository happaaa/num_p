import 'package:longnum/longnum.dart';

leadingzeros(longnum number) {
  // formatting
  number.integer = (number.value.reversed).toList();
  number.decimal = (number.decimal.reversed).toList();
  var k = number.value.length, l = number.decimal.length;
  for (var u = 0; u < k && number.integer[0] == 0; u++) {
    number.value.removeAt(0);
  }
  for (var v = 0; v < l && number.decimal[0] == 0; v++) {
    number.decimal.removeAt(0);
  }
}
