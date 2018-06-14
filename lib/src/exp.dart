/*
 * exponential functions for longnum
 * pow()
 * exp()
 * sqrt()
 * log()
 */

import 'longnum/longnumclass.dart';
import 'multiply.dart';

power(Longnum a, num power) {

}

power_list(List number, num exponent, [int power = 15]) {
  var number_image = number;
  if (exponent == 0) return new Longnum();
  for (var i = 1; i < exponent; i++) {
    number = multi_int(number, number_image, power: power);
  }
  return number;
}

powerlist2(List number, num exponent, [int power = 15]) {
  var i = 1;
  var number_image = number;
  for (i; i < exponent; i * 2) {
    squaring(number);
  }
  i /= 2;
  for (var i = 1; i < exponent; i++) {
    number = multifull(number, number_image);
  }
  return number;
}
