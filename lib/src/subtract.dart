/*
 * to be done:
 * make more concise
 * work with negative numbers
 *
 */

import 'dart:math';
import 'longnum/longnumclass.dart';
import 'format.dart';

subtract_master(Longnum a, Longnum b) {
  var ans = new Longnum();
  if (a == b) return ans;
  var q = a > b ? a.integer : b.integer;
  var w = q == a.integer ? b.integer : a.integer;
  var e = q == a.integer ? a.decimal : b.decimal;
  var r = q == a.integer ? b.decimal : a.decimal;
  var sign = q == b.integer;
  var dec = subtract_deci(e, r);
  var carry_dec = dec.first;
  dec.removeAt(0);
  ans.neg = sign;
  ans.decimal = dec;
  ans.integer = subtract_int(q, w, carry: carry_dec);
  //ans = leadingzeros_nump(ans);
  return ans;
}

subtract_int(List a, List b, {int carry = 0, int power = 15}) {
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

subtract_deci(List a, List b) {
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
