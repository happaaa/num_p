/*
 * formatting functions for other routines
 */

import 'longnum/longnumclass.dart';

// formatting
longnum leadingzeros_nump(longnum number) {
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
  //number.integer = (number.integer.reversed).toList();
  var k = number.length;
  for (var u = 0; u < k && number.first == 0; u++) {
    //print(number.length);
    if (number.length == 1) break;
    number.removeAt(0);
  }
  return number;
}

trailingzeros(longnum number) {

}
