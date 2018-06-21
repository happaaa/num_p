/*
 * exponential functions for longnum
 * pow()
 * exp()
 * sqrt()
 * log()
 */

import 'dart:math';
import 'longnum/longnumclass.dart';
import 'multiply.dart';

/*
 * power function
 */

power(Longnum number, num exponent) {
  if (exponent == 0) return new Longnum();
  var i = 2;
  var number_image = number;
  for (i; i <= exponent; i *= 2) {
    number = multimaster(number, number);
  }
  i ~/= 2;
  for (i; i < exponent; i++) {
    number = multimaster(number, number_image);
  }
  return number;
}

powerlist(List number, num exponent, [int power = 15]) {
  if (exponent == 0) return new Longnum();
  var i = 2;
  var number_image = number;
  for (i; i <= exponent; i *= 2) {
    number = squaring(number);
  }
  i ~/= 2;
  print('num after square: $number');
  for (i; i < exponent; i++) {
    number = multifull(number, number_image);
  }
  //print(number);
  return number;
}

/*
 * exponential exp() function
 */
exponential(num exponent) => power(longE, exponent);

/*
 * squareroot function
 */

//prototype
 babylon(var number) {
   final PRECISION = pow(10, -3);
   var len = (number.toString().length + 1) ~/ 2 - 1;
   var guess = pow(10, len) * (number.toString().length.isEven ? 7 : 2);
   print('start: $guess');
   while ((pow(guess, 2) - number).abs() > PRECISION) {
     guess = (guess + number / guess) / 2;
     print('guess: $guess');
   }
   return guess;
 }

 /*
  * natural logarithm function log()
  */

natural_log(Longnum number, num precision) {

}

ln_list(List number, num precision) {

}
