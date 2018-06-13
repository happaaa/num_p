/*
 * power functions for longnum
 * pow()
 * exp()
 * sqrt()
 * log()
 */

import 'longnum/longnumclass.dart';
import 'multiply.dart';

power(longnum a, num power) {

}

power_list(List number, num exponent, [int power = 15]) {
  var number_image = number;
  for (var i = 1; i < exponent; i++) {
    number = multi_int(number, number_image, power: power);
  }
  return number;
}
