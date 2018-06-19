import 'dart:math';
import 'package:longnum/src/add.dart';
import 'package:longnum/src/subtract.dart';
import 'package:longnum/src/multiply.dart';

final longE = new Longnum.string("2.718281828459045235360287471352662497757247093699959574966");
final longPI = new Longnum.string("3.141592653589793238462643383279502884197169399375105820974");
final longLN2 = new Longnum.string("0.693147180559945309417232121458176568075500134360255254120");
final longLN10 = new Longnum.string("2.302585092994045684017991454684364207601101488628772976033");
final longLOG2E = new Longnum.string("1.442695040888963407359924681001892137426645954152985934135");
final longLOG10E = new Longnum.string("0.434294481903251827651128918916605082294397005803666566114");
final longSQRT1_2 = new Longnum.string("0.707106781186547524400844362104849039284835937688474036588");
final longSQRT2 = new Longnum.string("1.414213562373095048801688724209698078569671875376948073176");


class Longnum {
  List integer = new List();
  List decimal = new List();
  bool neg = false;

  /*
   * constructors
   */
  // default constructor (don't really need this)
  Longnum() {
    integer = [0];
    decimal = [0];
    neg = false;
  }

  // constructor from string
  Longnum.string(String string) {
    int j = 0;
    var string_list = string.split('.');

    if (string.startsWith('-')) {
      neg = true;
      j = 1;
    }

    for (int i = string_list.first.length; i > j; i -= 15) {
      integer.add(int.parse((i - 15 < j) ? string_list.first.substring(j, i)
                                         : string_list.first.substring(i - 15, i)));
    }
    if (string_list.length == 2) {
      for (int i = 0; i < string_list[1].length; i += 15) {
        if (i + 15 > string_list[1].length) {
          decimal.add(int.parse(string_list[1].substring(i, string_list[1].length)));
          var dec_len = string_list[1].substring(i, string_list[1].length).length;
          decimal[decimal.length - 1] *= pow(10, 15 - dec_len);
        }
        else {
          decimal.add(int.parse(string_list[1].substring(i, i + 15)));
        }
      }
    }
    else {
      decimal.add(0);
    }
    integer = integer.reversed.toList();
  }

  // constructor from num
  Longnum.number(num number) {
    if (number.isNegative) {
      neg = true;
      number = number.abs();
    }
    var string_list = (number.toString()).split('.');
    if (string_list.length == 2) {
      var dec_len = string_list[1].length;
      decimal.add(int.parse(string_list[1]) * pow(10, 15 - dec_len));
    }
    else {
      decimal.add(0);
    }
    integer.add(number.floor());
  }

  /*
   * setters
   */
  set value(String string) {
    integer.clear();
    decimal.clear();
    neg = false;

    int j = 0;
    var string_list = string.split('.');

    if (string.startsWith('-')) {
      neg = true;
      j = 1;
    }

    for (int i = string_list.first.length; i > j; i -= 15) {
      integer.add(int.parse((i - 15 < j) ? string_list.first.substring(j, i)
                                         : string_list.first.substring(i - 15, i)));
    }
    if (string_list.length == 2) {
      for (int i = 0; i < string_list[1].length; i += 15) {
        if (i + 15 > string_list[1].length) {
          decimal.add(int.parse(string_list[1].substring(i, string_list[1].length)));
          var dec_len = string_list[1].substring(i, string_list[1].length).length;
          decimal[decimal.length - 1] *= pow(10, 15 - dec_len);
        }
        else {
          decimal.add(int.parse(string_list[1].substring(i, i + 15)));
        }
      }
    }
    else {
      decimal.add(0);
    }
    integer = integer.reversed.toList();
  }

  /*
   * getters
   */
  List get val => [neg, integer, decimal];

  int get hashCode { // hashcode for == operator
    int hash = 45;
    hash = 37 * hash + integer.length + integer[0];
    hash = 2 * decimal.length * hash + decimal[0];
    return hash;
  }

  num get doub {
      var number = integer[0] + decimal[0] * pow(10, -15);
      if (neg) number *= -1;
      return number;
  }

  String get stri {
    var number = '';
    if (neg) number = '-';
    for (int i = 0; i < integer.length; i++) {
      number += integer[i].toString();
    }
    number += '.';
    for (int i = 0; i < decimal.length; i++) {
      number += decimal[i].toString();
    }
    return number;
  }


  /*
   * overloaded operators
   *  - eventually have to integrate functions into here
   *    because recursion importing doesn't work
   */
  Longnum operator+(Longnum operand) {
    var ans = new Longnum();
    if (!neg && !operand.neg) {
      ans = add_master(this, operand);
    }
    else if (!neg && operand.neg) {
      ans = subtract_master(this, operand);
    }
    else if (neg && !operand.neg) {
      ans = subtract_master(operand, this);
    }
    else {
      ans = add_master(this, operand);
      ans.neg = true;
    }
    return ans;
  }

  Longnum operator-(Longnum operand) {
    var ans = new Longnum();
    if (!neg && !operand.neg) {
      ans = subtract_master(this, operand);
    }
    else if (!neg && operand.neg) {
      ans = add_master(this, operand);
    }
    else if (neg && !operand.neg) {
      ans = add_master(this, operand);
      ans.neg = true;
    }
    else {
      ans = subtract_master(operand, this);
    }
    return ans;
  }

  Longnum operator*(Longnum operand) {
    Longnum ans = multimaster(this, operand);
    ans.neg = (!neg && operand.neg) || (!neg && operand.neg);
    return ans;
  }

  /*
   * left to go: /, ~/
   *
   */

  bool operator>(Longnum operand) => compare(this, operand) == 1;
  bool operator>=(Longnum operand) => compare(this, operand) != 0;
  bool operator<(Longnum operand) => compare(this, operand) == 0;
  bool operator<=(Longnum operand) => compare(this, operand) != 1;
  bool operator==(Longnum operand) => compare(this, operand) == 2;



  /*
   * helper functions for overloaded operators
   */
  num compare(Longnum a, Longnum b) {
    if (!a.neg && b.neg) return 1;
    else if (a.neg && !b.neg) return 0;
    else if (a.neg && b.neg) {
      // reverse the values if both are negative
      var c = new Longnum();
      c = a;
      a = b;
      b = c;
    }
    if (a.integer.length > b.integer.length) return 1;
    else if (a.integer.length > b.integer.length) return 0;
    else {
      for (var i = 0; i < a.integer.length; i++) {
        if (a.integer[i] > b.integer[i]) return 1;
        if (a.integer[i] < b.integer[i]) return 0;
      }
    }
    var maxi = max(a.decimal.length, b.decimal.length);
    var mini = min(a.decimal.length, b.decimal.length);
    for (var i = 0; i < mini; i++) {
      if (a.decimal[i] > b.decimal[i]) return 1;
      if (a.decimal[i] < b.decimal[i]) return 0;
    }
    if (maxi > mini) {
      return a.decimal.length == maxi ? 1 : 0;
    }
    else return 2;
  }



}
