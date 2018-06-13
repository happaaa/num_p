import 'dart:math';
import 'package:longnum/src/add.dart';
import 'package:longnum/src/subtract.dart';

class longnum {
  static final E_string = "2.718281828459045235360287471352662497757247093699959574966";
  static final PI_string = "3.141592653589793238462643383279502884197169399375105820974";
  static final LN2_string = "0.693147180559945309417232121458176568075500134360255254120";
  static final LN10_string = "2.302585092994045684017991454684364207601101488628772976033";
  static final LOG2E_string = "1.442695040888963407359924681001892137426645954152985934135";
  static final LOG10E_string = "0.434294481903251827651128918916605082294397005803666566114";
  static final SQRT1_2_string = "0.707106781186547524400844362104849039284835937688474036588";
  static final SQRT2_string = "1.414213562373095048801688724209698078569671875376948073176";

  List integer = new List();
  List decimal = new List();
  bool neg = false;

  /*
   * constructors
   */
  // default constructor (don't really need this)
  longnum() {
    integer = [0];
    decimal = [0];
    neg = false;
  }

  // constructor from string
  longnum.string(String string) {
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
        decimal.add(int.parse((i + 15 > string_list[1].length) ? string_list[1].substring(i, string_list[1].length)
                                                               : string_list[1].substring(i, i + 15)));
      }
    }
    else {
      decimal.add(0);
    }
    integer = integer.reversed.toList();
  }

  // constructor from num
  // might have to change from convert to string and back to int
  longnum.number(num number) {
    if (number.isNegative) {
      neg = true;
      number = number.abs();
    }
    var string_list = (number.toString()).split('.');
    string_list.length == 2 ? decimal.add(int.parse(string_list[1])) : decimal.add(0);
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
        decimal.add(int.parse((i + 15 > string_list[1].length) ? string_list[1].substring(i, string_list[1].length)
                                                               : string_list[1].substring(i, i + 15)));
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


  /*
   * overloaded operators
   *  - eventually have to integrate functions into here
   *    because recursion importing doesn't work
   */
  longnum operator+ (longnum operand) {
    var ans = new longnum();
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

  longnum operator- (longnum operand) {
    var ans = new longnum();
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

  /*
   * left to go: *, /, ~/
   *
   */

  bool operator> (longnum operand) => compare(this, operand) == 1;
  bool operator>= (longnum operand) => compare(this, operand) != 0;
  bool operator< (longnum operand) => compare(this, operand) == 0;
  bool operator<= (longnum operand) => compare(this, operand) != 1;
  bool operator== (longnum operand) => compare(this, operand) == 2;



  /*
   * helper functions for overloaded operators
   */
  num compare(longnum a, longnum b) {
    if (!a.neg && b.neg) return 1;
    else if (a.neg && !b.neg) return 0;
    else if (a.neg && b.neg) {
      // reverse the values if both are negative
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
