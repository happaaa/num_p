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

power(Longnum a, num power) {

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
  print(number);
  return number;
}

/*
 * exponential exp() function
 */
exponential(Longnum number) => multimaster(E, number); // fix

/*
 * squareroot function
 */

//prototype
 babylon(var number) {
   var len = (number.toString().length + 1) ~/ 2;
   var guess = pow(10, len - 1) * (number.toString().length.isEven ? 7 : 2);
   print(guess);
   while ((pow(guess, 2) - number).abs() > 0.001) {
     guess = (guess + number / guess) / 2;
     print('guess: $guess');
   }
   return guess;
 }
