import 'dart:math';
import 'package:quiver_hashcode/hashcode.dart';
//import 'package:longnum/src/add.dart';
//import 'package:longnum/src/subtract.dart';
//import 'package:longnum/src/multiply.dart';
import 'package:longnum/src/divide.dart';

final longE = new Longnum.string("2.718281828459045235360287471352662497757247093699959574966");
final longPI = new Longnum.string("3.141592653589793238462643383279502884197169399375105820974");
final longLN2 = new Longnum.string("0.693147180559945309417232121458176568075500134360255254120");
final longLN10 = new Longnum.string("2.302585092994045684017991454684364207601101488628772976033");
final longLOG2E = new Longnum.string("1.442695040888963407359924681001892137426645954152985934135");
final longLOG10E = new Longnum.string("0.434294481903251827651128918916605082294397005803666566114");
final longSQRT1_2 = new Longnum.string("0.707106781186547524400844362104849039284835937688474036588");
final longSQRT2 = new Longnum.string("1.414213562373095048801688724209698078569671875376948073176");

/*
 * to do:
 * make integer and decimal a single list with a radix point to signify decimal
 */

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
    if (!neg && !operand.neg) {
      ans = this.add_master(operand);
    }
    else if (!neg && operand.neg) {
      ans = this.subtract_master(operand);
    }
    else if (neg && !operand.neg) {
      neg = false;
      ans = operand.subtract_master(this);
    }
    else {
      ans = this.add_master(operand);
      ans.neg = true;
    }
    return ans;
  }

  Longnum operator-(Longnum operand) {
    var ans = new Longnum();
    if (!neg && !operand.neg) {
      ans = this.subtract_master(operand);
    }
    else if (!neg && operand.neg) {
      ans = this.add_master(operand);
    }
    else if (neg && !operand.neg) {
      ans = this.add_master(operand);
      ans.neg = true;
    }
    else {
      ans = operand.subtract_master(this);
    }
    return ans;
  }

  Longnum operator*(Longnum operand) {
    Longnum ans = this.multimaster(operand);
    ans.neg = (!neg && operand.neg) || (!neg && operand.neg);
    return ans;
  }

  Longnum operator/(Longnum operand) {
    Longnum ans = divmaster(this, operand);
    ans.neg = (!neg && operand.neg) || (!neg && operand.neg);
    return ans;
  }

  Longnum operator~/(Longnum operand) {
    Longnum ans = this / operand;
    ans.decimal = [0];
    return ans;
  }

  bool operator>(Longnum operand) => this.compare(operand) == 1;
  bool operator>=(Longnum operand) => this.compare(operand) != 0;
  bool operator<(Longnum operand) => this.compare(operand) == 0;
  bool operator<=(Longnum operand) => this.compare(operand) != 1;
  bool operator==(Longnum operand) => this.compare(operand) == 2;



  /*
   * helper functions for overloaded operators
   */
  num compare(Longnum other) {
    var x = this;
    if (!x.neg && other.neg) return 1;
    else if (x.neg && !other.neg) return 0;
    else if (x.neg && other.neg) {
      // reverse the values if both are negative
      var c = x;
      x = other;
      other = c;
    }
    if (x.integer.length > other.integer.length) return 1;
    else if (x.integer.length > other.integer.length) return 0;
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

  Longnum add_master(Longnum other) {
    var ans = new Longnum();
    var deci = add_deci(this.decimal, other.decimal);
    var carry_deci = 0;
    if (deci.first == 1) {
      carry_deci = 1;
      deci.removeAt(0);
    }
    ans.decimal = deci;
    ans.integer = add_int(this.integer, other.integer, carry: carry_deci);
    //ans = leadingzeros_nump(ans);
    return ans;
  }

  List add_int(List a, List b, {int carry = 0, int power = 15}) {
    final BASE = pow(10, power);
    var ans = [0];
    var size = max(a.length, b.length);
    var c = size == a.length ? a : b;
    var d = c == a ? b : a;
    var d_length = d.length;

    for (var i = 0; i < size - d_length; i++) {
      d.insert(0, 0);
    }
    //print('c: $c');
    //print('d: $d');
    for (var i = size - 1; i >= 0; i--) {
      ans[0] = (c[i] + d[i] + carry) % BASE;
      carry = ((c[i] + d[i] + carry) / BASE).floor();
      ans.insert(0, 0);
      //print('carry: $carry');
      //print('ANS: $ans');
    }
    if (carry == 1) {
      ans[0] = 1;
    }
    ans = leadingzeroslist(ans);
    d = leadingzeroslist(d);
    return ans;
  }

  List add_deci(List a, List b) {
    final BASE = pow(10, 15);
    var ans = [0];
    var size = max(a.length, b.length);
    var c = size == a.length ? a : b;
    if (a.length == b.length) {
      c = a.last.toString().length > b.last.toString().length ? a : b;
    }
    var d = c == a ? b : a;
    var d_length = d.length;
    var carry = 0;

    for (int i = 0; i < size - d_length; i++) {
      d.add(0);
    }
    //print('c: $c');
    //print('d: $d');
    for (int i = size - 1; i >= 0; i--) {
      ans[0] = (c[i] + d[i] + carry) % BASE;
      carry = ((c[i] + d[i] + carry) / BASE).floor();
      ans.insert(0, 0);
      //print('ans: $ans');
    }
    ans.removeAt(0);
    if (carry == 1) {
      ans.insert(0, 1);
    }
    return ans;
  }

  Longnum subtract_master(Longnum other) {
    var ans = new Longnum();
    if (this == other) return ans;
    var q = this > other ? this.integer : other.integer;
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

  List subtract_int(List a, List b, {int carry = 0, int power = 15}) {
    final BASE = pow(10, power);
    var ans = [0];
    var size = a.length;
    var b_length = b.length;

    for (int i = 0; i < size - b_length; i++) {
      b.insert(0, 0);
    }
    //print('int a: $a');
    //print('int b: $b');
    for (int i = size - 1; i >= 0; i--) {
      ans[0] = (a[i] - b[i] + carry) % BASE;
      carry = ((a[i] - b[i] + carry) / BASE).floor();
      ans.insert(0, 0);
      //print('int ans: $ans');
    }
    ans = leadingzeroslist(ans);
    b = leadingzeroslist(b);
    return ans;
  }

  List subtract_deci(List a, List b) {
    final BASE = pow(10, 15);
    var ans = [0];
    var size = max(a.length, b.length);
    var carry = 0;
    //var a_length = a.length;
    //var b_length = b.length;

    if (a.length == size) {
      for (var i = b.length; i < size; i++) {
        b.add(0);
      }
    }
    else if (b.length == size) {
      for (var i = a.length; i < size; i++) {
        a.add(0);
      }
    }
    //print('a: $a');
    //print('b: $b');
    for (var i = size - 1; i >= 0; i--) {
      ans[0] = (a[i] - b[i] + carry) % BASE;
      carry = ((a[i] - b[i] + carry) / BASE).floor();
      ans.insert(0, 0);
      //print('ans: $ans');
    }
    ans.removeAt(0);
    carry == -1 ? ans.insert(0, -1) : ans.insert(0, 0);
    return ans;
  }

  // long multiplication with the new Longnum class
  Longnum multimaster(Longnum other) {
    var ans = new Longnum();
    var a_list = new List.from(this.integer)..addAll(this.decimal);
    var b_list = new List.from(other.integer)..addAll(other.decimal);
    var dec_len = this.decimal.length + other.decimal.length;
    var product;

    if (this == other) {
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
    trailingzeroslist(ans.decimal);
    return ans;
  }

  List multifull(List a, List b) {
    var ans = [0];
    var bk = a.length;
    var bm = b.length;
    var q = [0];
    for (int i  = 0; i < bk; i++) {
      for (int j = 0; j < bm; j++) {
        //print('Q: $q');
        //print('a[${bk - 1 - i}]: ${a[bk - i - 1]}');
        //print('b[${bm - 1 - j}]: ${b[bm - j - 1]}');
        var t = add_int(add_int([ans[i + j]], q), timesNum(a[bk - i - 1], b[bm - j - 1]));
        //print('t: $t');
        ans[i + j] = t.last;
        q = t.sublist(0, t.length - 1);
        if (q.isEmpty) {
          q.add(0);
        }
        ans.add(0);
      }
      ans[i + bm] = q.first;
      q = [0];
    }
    ans = ans.reversed.toList();
    ans = leadingzeroslist(ans);
    return ans;
  }

  List timesNum(num a, num b) {
    final BASE = pow(10, 7);
    final BASE_2 = pow(10, 14);
    if (a.toString().length + b.toString().length > 15) {
      var alist = new List(3);
      var blist = new List(3);
      alist[2] = a % BASE;
      alist[1] = (a % BASE_2 - alist[2]) ~/ BASE;
      alist[0] = a ~/ BASE_2;
      blist[2] = b % BASE;
      blist[1] = (b % BASE_2 - blist[2]) ~/ BASE;
      blist[0] = b ~/ BASE_2;
      //print(alist);
      //print(blist);
      var newlist = [0];
      var bk = alist.length;
      var bm = blist.length;
      var q = 0;
      for (int i  = 0; i < bk; i++) {
        for (int j = 0; j < bm; j++) {
          var t = newlist[i + j] + q + alist[bk - i - 1] * blist[bm - j - 1];
          newlist[i + j] = t % BASE;
          q = (t / BASE).floor();
          newlist.add(0);
        }
        newlist[i + bm] = q;
        q = 0;
      }
      newlist = trailingzeroslist(newlist);
      var ans = [0, 0];
      //print('newlist: $newlist');
      switch (newlist.length) {
        case 5:
        ans[0] = newlist[4] * pow(10, 13);
        continue case4;
        case4:
        case 4:
        ans[0] += newlist[3] * pow(10, 6);
        continue case3;
        case3:
        case 3:
        ans[0] += newlist[2] ~/ 10;
        ans[1] = newlist[0] + newlist[1] * BASE + (newlist[2] % 10) * BASE_2;
      }
      ans = leadingzeroslist(ans);
      return ans;
    }
    else {
      return [a * b];
    }
  }

  List squaring(List number) {
    var ans = [0, 0];
    var q = [0];
    for (var i = 0; i < number.length - 1; i++) {
      for (var j = i + 1; j < number.length; j++) {
        //print('number: ${number[number.length - i - 1]} and other number: ${number[number.length - j - 1]}');
        var product = timesNum(number[number.length - i - 1], number[number.length - j - 1]);
        product = multifull(product, [2]);
        //print('product: $product');
        var t = add_int(add_int([ans[i + j]], q), product);
        ans[i + j] = t.last;
        q = t.sublist(0, t.length - 1);
        if (q.isEmpty) {
          q.add(0);
        }
        ans.add(0);
        //print('product ans: $ans');
        //print('q: $q');
      }
      ans[i + number.length] = q.first;
      q = [0];
    }
    ans = ans.reversed.toList();
    leadingzeroslist(ans);
    //print('ans before squares: $ans');
    for (var i = 0; i < number.length; i++) {
      var square = timesNum(number[number.length - i - 1], number[number.length - i -1]);
      for (var j = 0; j < i * 2; j++) {
        square.add(0);
      }
      //print('square: $square');
      ans = add_int(ans, square);
      //print('square ans: $ans');
    }
    //print(ans);
    return ans;
  }

  /*
   * I SPENT AN ENTIRE BLOODY DAY TRYING TO FIX THIS ONLY TO REALIZE IT WAS BECAUSE I MESSED UP
   * AN ADD FUNCTION I HATE CODING
   */
  List karatsuba(List a, List b, [int power = 15]) {
    var max_size = max(a.length, b.length);
    int i = 0;
    if (max_size == 1) {
      return timesNum(a.first, b.first);
    }

    var c = max_size == a.length ? a : b;
    var d = c == a ? b : a;
    var d_length = d.length;

    for (var i = 0; i < max_size - d_length; i++) {
      d.insert(0, 0);
    }
    //print('c? $c');
    //print('d: $d');
    while (max_size > pow(2, i)) {
      i++;
    }

    int power_2 = pow(2, i - 1).toInt();
    var c0 = c.sublist(0, power_2);
    var c1 = c.sublist(power_2, a.length);
    var d0 = d.sublist(0, power_2);
    var d1 = d.sublist(power_2, b.length);
    //print('c0: $c0);
    //print('c11: $c1);
    //print('d0: $d0);
    //print('d11: $d1);
    var t1 = karatsuba(c1, d1, power);
    var t2 = karatsuba(c0, d0, power);
    var t3 = karatsuba(add_int(c0, c1, power: power), add_int(d0, d1, power: power), power);
    var t4 = subtract_int(subtract_int(t3, t2, power: power), t1, power: power);
    //print("ans: $t2 $t4 $t1");

    for (int i = 0; i < c1.length; i++) {
      t4.add(0);
    }
    for (int i = 0; i < c1.length * 2; i++) {
      t2.add(0);
    }
    var ans = add_int(add_int(t1, t4, power: power), t2, power: power);
    return ans;
  }


}
