/*
 * formatting functions for other routines
 */

import 'package:longnum/src/longnum/longnumclass.dart';

// formatting
Longnum leadingzeros_nump(Longnum number) {
  //number.integer = (number.integer.reversed).toList();
  //number.decimal = (number.decimal.reversed).toList();
  var k = number.integer.length, l = number.decimal.length;
  for (var u = 0; u < k && number.integer.first == 0; u++) {
    if (number.integer.length == 1) break;
    number.integer.removeAt(0);
  }
  for (var v = 0; v < l && number.decimal.first == 0; v++) {
    if (number.decimal.length == 1) break;
    number.decimal.removeAt(0);
  }
  return number;
}

List leadingzeroslist(List number) {
  var k = number.length;
  for (var u = 1; u < k && number.first == 0; u++) {
    number.removeAt(0);
  }
  return number;
}

List trailingzeroslist(List number) {
  while (number.length != 1 && number.last == 0) {
    number.removeAt(number.length - 1);
  }
  return number;
}
