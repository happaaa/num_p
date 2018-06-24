/*
 * exponential functions for longnum
 * pow()
 * exp()
 * sqrt()
 * log()
 */

import 'dart:math';
import 'longnum/longnumclass.dart';
import 'add.dart';
import 'multiply.dart';
import 'divide.dart';

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

// list power function
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
babylonlist(List number) {
  var len = (number.length + 1) ~/ 2 - 1;
  var guess = number.length.isEven ? [7] : [2];
  for (var i = 0; i < len; i++) {
    guess.add(0);
  }
  print('start: $guess');
  var test = div_sub_helper(squaring(guess), number).remove(-1);
  while (test > [1]) {
    guess = long_div(add_int(guess, long_div(number, guess)), [2]);
    print('guess: $guess');
  }
  return guess;
}


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

ln(Longnum number, num precision) {
  var a = new Longnum.number(-0.6296735);
  var b = new Longnum.number(2.726314);
  var c = new Longnum.number(-2.096641);

  // need to find largest power of 2 smaller than num
}

// very very rough approximation
ln_list_approx(List number, num precision, [int power = 15]) {
  var len = number.length - 1;
  return log(number[0]) + len * log(pow(10, power));

}
