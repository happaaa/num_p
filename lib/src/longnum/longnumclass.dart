import 'dart:math';
import 'package:quiver_hashcode/hashcode.dart';
import 'helper.dart';

/*
 * math constants, extended to 60 decimal places
 */
final longE = new Longnum.string("2.718281828459045235360287471352662497757247093699959574966967");
final longPI = new Longnum.string("3.141592653589793238462643383279502884197169399375105820974944");
final longLN2 = new Longnum.string("0.693147180559945309417232121458176568075500134360255254120680");
final longLN10 = new Longnum.string("2.302585092994045684017991454684364207601101488628772976033327");
final longLOG2E = new Longnum.string("1.442695040888963407359924681001892137426645954152985934135449");
final longLOG10E = new Longnum.string("0.434294481903251827651128918916605082294397005803666566114453");
final longSQRT1_2 = new Longnum.string("0.707106781186547524400844362104849039284835937688474036588339");
final longSQRT2 = new Longnum.string("1.414213562373095048801688724209698078569671875376948073176679");

Longnum exponential(num exponent) => longE.power(exponent);
Longnum maximum(Longnum one, Longnum other) => one >= other ? one : other;
Longnum minimum(Longnum one, Longnum other) => one <= other ? one : other;

/*
 * to do:
 * make integer and decimal a single list with a radix point to signify decimal
 * implement Jebelean exact division algorithm
 */
class Longnum {
  List integer = new List();
  List decimal = new List();
  bool neg = false;

  /*
   * constructors
   */
  Longnum() {
    integer = [0];
    decimal = [0];
    neg = false;
  }

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
    integer = lead0(integer.reversed.toList());
    decimal = trail0(decimal);
  }

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
    integer = lead0(integer.reversed.toList());
    decimal = trail0(decimal);
  }

  /*
   * getters
   */
  List get val => [neg, integer, decimal];

  int get hashCode => hash3(neg, hashObjects(integer), hashObjects(decimal));

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
    if (!neg && !operand.neg) ans = this.addmaster(operand);
    else if (!neg && operand.neg) ans = this.subtractmaster(operand);
    else if (neg && !operand.neg) ans = operand.subtractmaster(this);
    else {
      ans = this.addmaster(operand);
      ans.neg = true;
    }
    return ans;
  }

  Longnum operator-(Longnum operand) {
    var ans = new Longnum();
    if (!neg && !operand.neg) ans = this.subtractmaster(operand);
    else if (!neg && operand.neg) ans = this.addmaster(operand);
    else if (neg && !operand.neg) {
      ans = this.addmaster(operand);
      ans.neg = true;
    }
    else ans = operand.subtractmaster(this);
    return ans;
  }

  Longnum operator*(Longnum operand) {
    Longnum ans = this.multimaster(operand);
    if (ans == new Longnum()) return ans;
    ans.neg = (!neg && operand.neg) || (neg && !operand.neg);
    return ans;
  }

  Longnum operator/(Longnum operand) {
    Longnum ans = this.divmaster(operand);
    if (ans == new Longnum()) return ans;
    ans.neg = (!neg && operand.neg) || (neg && !operand.neg);
    return ans;
  }

  Longnum operator~/(Longnum operand) => this.divmaster(operand, 0);

  Longnum operator%(Longnum operand) {
    var ans = new Longnum();
    var thislist = new List.from(this.integer)..addAll(this.decimal);
    var otherlist = new List.from(operand.integer)..addAll(operand.decimal);
    var size = max(this.decimal.length, operand.decimal.length);
    if (operand == ans) throw IntegerDivisionByZeroException;
    if (this == operand) return ans;
    if (this < operand) return this;

    if (this.decimal.length == size) {
      for (var i = operand.decimal.length; i < size; i++) {
        otherlist.add(0);
      }
    }
    else if (operand.decimal.length == size) {
      for (var i = this.decimal.length; i < size; i++) {
        thislist.add(0);
      }
    }
    if (operand < new Longnum.number(1) && operand > new Longnum.number(-1)) {
      otherlist.removeAt(0);
    }
    final BASE = pow(10, 15);
    var constant = 1;
    if (otherlist[0] < BASE / 2) {
      constant = ((BASE / 2) / otherlist[0]).ceil();
      thislist = multifull(thislist, [constant]);
      otherlist = multifull(otherlist, [constant]);
    }
    //print('thislist: $thislist and otherlist $otherlist and const $constant');
    var quotient = long_div(thislist, otherlist);
    var constant2 = 1;
    if (constant < BASE / 2) {
      constant2 = ((BASE / 2) / constant).ceil();
      quotient[1] = multifull(quotient[1], [constant2]);
      quotient[0] = multifull([constant], [constant2]);
    }
    //print('${quotient[1]} and ${quotient[0]}');
    var remainder = long_div(quotient[1], quotient[0]);
    //print('remainder: $remainder');
    ans.integer = remainder[0].sublist(0, remainder[0].length - size);
    ans.decimal = remainder[0].sublist(remainder[0].length - size, remainder[0].length);
    return ans;
  }

  bool operator>(Longnum operand) => this.compare(operand) == 1;
  bool operator>=(Longnum operand) => this.compare(operand) != 0;
  bool operator<(Longnum operand) => this.compare(operand) == 0;
  bool operator<=(Longnum operand) => this.compare(operand) != 1;
  bool operator==(Longnum operand) => this.compare(operand) == 2;

  Longnum abs() {
    var number = new Longnum();
    number.integer = integer;
    number.decimal = decimal;
    number.neg = false;
    return number;
  }

  /*
   * exponential functions
   */
  Longnum power(num exponent) {
    if (exponent == 0) return new Longnum();
    var number = this;
    var i = 2;
    var number_image = number;
    for (i; i <= exponent; i *= 2) {
      number = number.multimaster(number);
    }
    i ~/= 2;
    for (i; i < exponent; i++) {
      number = number.multimaster(number_image);
    }
    return number;
  }

  Longnum squareroot([Longnum precision]) {
    var ans = new Longnum();
    var len = (this.integer.length + 1) ~/ 2 - 1;
    precision = precision ?? new Longnum.number(0.001);
    if (neg == true) throw IntegerDivisionByZeroException;
    ans.integer = this.integer.length.isEven ? [2000] : [7000];
    for (var i = 0; i < len; i++) {
      ans.integer.add(0);
    }
    var test;
    //print('start: ${ans.val}');
    do {
      ans = (ans + this.divmaster(ans, this.decimal.length + 1)).divmaster(new Longnum.number(2), this.decimal.length + 1);
      print('guess: ${ans.val}');
      test = ans.power(2) - this;
      test.neg = false;
    } while (test > precision);
    return ans;
  }

  num ln() {
    var len = this.integer.length - 1;
    return log(this.integer[0]) + len * log(pow(10, 15));
  }

  num sine() {
    Longnum ans = this % (new Longnum.number(2) * longPI);
    if (ans == longPI || ans == new Longnum()) return 0;
    return sin(ans.doub);
  }

  num cosine() {
    Longnum ans = this % (new Longnum.number(2) * longPI);
    if (ans == longPI / new Longnum.number(2) ||
        ans == new Longnum.number(3) * longPI / new Longnum.number(2)) return 0;
    return cos(ans.doub);
  }

  num tangent() {
    Longnum ans = this % (new Longnum.number(2) * longPI);
    if (ans == longPI / new Longnum.number(2) ||
        ans == new Longnum.number(3) * longPI / new Longnum.number(2)) throw new Exception('Infinity');
    else if (ans == longPI || ans == new Longnum()) return 0;
    return tan(ans.doub);
  }





  /*
   * helper functions for overloaded operators
   */
  num compare(Longnum other) {
    var x = this;
    if (!x.neg && other.neg) return 1;
    else if (x.neg && !other.neg) return 0;
    else if (x.neg && other.neg) {
      // reverse the values if both are negative
      var temp = x;
      x = other;
      other = temp;
    }
    if (x.integer.length > other.integer.length) return 1;
    else if (x.integer.length < other.integer.length) return 0;
    else {
      for (var i = 0; i < x.integer.length; i++) {
        if (x.integer[i] > other.integer[i]) return 1;
        if (x.integer[i] < other.integer[i]) return 0;
      }
    }
    var maxi = max(x.decimal.length, other.decimal.length);
    var mini = min(x.decimal.length, other.decimal.length);
    for (var i = 0; i < mini; i++) {
      if (x.decimal[i] > other.decimal[i]) return 1;
      if (x.decimal[i] < other.decimal[i]) return 0;
    }
    if (maxi > mini) {
      return x.decimal.length == maxi ? 1 : 0;
    }
    else return 2;
  }

  Longnum addmaster(Longnum other) {
    var ans = new Longnum();
    var deci = add_deci(this.decimal, other.decimal);
    var carry_deci = 0;
    if (deci.first == 1) {
      carry_deci = 1;
      deci.removeAt(0);
    }
    ans.decimal = deci;
    ans.integer = add_int(this.integer, other.integer, carry: carry_deci);
    return ans;
  }

  Longnum subtractmaster(Longnum other) {
    var ans = new Longnum();
    if (this == other) return ans;
    //print('this: ${this.val} and other: ${other.val}');
    var q = (this.abs() > other.abs()) ? this.integer : other.integer;
    var w = q == this.integer ? other.integer : this.integer;
    var e = q == this.integer ? this.decimal : other.decimal;
    var r = q == this.integer ? other.decimal : this.decimal;
    var sign = q == other.integer;
    var dec = subtract_deci(e, r);
    var carry_dec = dec.first;
    dec.removeAt(0);
    ans.neg = sign;
    ans.decimal = dec;
    ans.integer = subtract_int(q, w, carry: carry_dec);
    return ans;
  }

  Longnum multimaster(Longnum other) {
    var ans = new Longnum();
    var a_list = new List.from(this.integer)..addAll(this.decimal);
    var b_list = new List.from(other.integer)..addAll(other.decimal);
    var dec_len = this.decimal.length + other.decimal.length;
    var product;
    if (this == ans || other == ans) {
      return ans;
    }
    else if (this == other) {
      product = squaring(a_list);
    }
    else if (max(a_list.length, b_list.length) < 500) {
      product = multifull(a_list, b_list);
    }
    else {
      product = karatsuba(a_list, b_list);
    }
    ans.integer = product.sublist(0, product.length - dec_len);
    ans.decimal = product.sublist(product.length - dec_len, product.length);
    if (ans.integer.length == 0) ans.integer.add(0);
    trail0(ans.decimal);
    return ans;
  }

  Longnum divmaster(Longnum other, [int precision]) {
    var ans = new Longnum();
    var thislist = new List.from(this.integer)..addAll(this.decimal);
    var otherlist = new List.from(other.integer)..addAll(other.decimal);
    var dec_len = precision ?? this.decimal.length + other.decimal.length;

    var size = max(this.decimal.length, other.decimal.length);

    if (this.decimal.length == size) {
      for (var i = other.decimal.length; i < size; i++) {
        otherlist.add(0);
      }
    }
    else if (other.decimal.length == size) {
      for (var i = this.decimal.length; i < size; i++) {
        thislist.add(0);
      }
    }

    if (other == ans) {
      throw IntegerDivisionByZeroException;
    }
    if (this == other) {
      ans.integer = [1];
      return ans;
    }
    if (other < new Longnum.number(1) && other > new Longnum.number(-1)) {
      otherlist.removeAt(0);
    }
    final BASE = pow(10, 15);
    var constant = 1; // regulating divisor to be half of 10^power
    if (otherlist[0] < BASE / 2) {
      constant = ((BASE / 2) / otherlist[0]).ceil();
      thislist = multifull(thislist, [constant]);
      otherlist = multifull(otherlist, [constant]);
    }
    if (max(thislist.length, otherlist.length) < 100) {
      var quotient = long_div(thislist, otherlist);
      ans.integer = quotient[0];

      for (var i = 0; i < dec_len; i++) {
        quotient[1].add(0);
        quotient = long_div(quotient[1], otherlist);
        ans.decimal.add(quotient[0][0]);
      }
    }
    else {
      if (otherlist.length.isOdd) {
        thislist.add(0);
        otherlist.add(0);
      }
      var quotient = two_by_one(thislist, otherlist);
      ans.integer = quotient[0];

      for (var i = 0; i < dec_len; i++) {
        quotient[1].add(0);
        quotient = two_by_one(quotient[1], otherlist);
        ans.decimal.add(quotient[0][0]);
      }
    }
    if (ans.decimal.length >= 2) ans.decimal.removeAt(0);
    trail0(ans.decimal);
    lead0(ans.integer);
    return ans;
  }

}
