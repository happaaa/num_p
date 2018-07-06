/*
 * wip:
 * work with decimals (not sure) - FIXED
 * work with negative numbers - FIXED
 * clean up code
 */

import 'dart:math';
import 'package:longnum/src/longnum/longnumclass.dart';
import 'format.dart';
import 'add.dart';
import 'subtract.dart';

// long multiplication with the new Longnum class
Longnum multimaster(Longnum a, Longnum b) {
  var ans = new Longnum();
  var a_list = new List.from(a.integer)..addAll(a.decimal);
  var b_list = new List.from(b.integer)..addAll(b.decimal);
  var dec_len = a.decimal.length + b.decimal.length;
  var product;

  if (a == b) {
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

List squaring(List a) {
  var ans = [0, 0];
  var q = [0];
  for (var i = 0; i < a.length - 1; i++) {
    for (var j = i + 1; j < a.length; j++) {
      //print('a: ${a[a.length - i - 1]} and other a: ${a[a.length - j - 1]}');
      var product = timesNum(a[a.length - i - 1], a[a.length - j - 1]);
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
    ans[i + a.length] = q.first;
    q = [0];
  }
  ans = ans.reversed.toList();
  leadingzeroslist(ans);
  //print('ans before squares: $ans');
  for (var i = 0; i < a.length; i++) {
    var square = timesNum(a[a.length - i - 1], a[a.length - i -1]);
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
 * to be fixed
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
  //print('c0-d1');
  //print(c0);
  //print(c1);
  //print(d0);
  //print(d1);
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
