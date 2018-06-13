/*
 * 6.5.18 made into seperate function for other programs
 * to be done:
 * make more concise
 * work with negative numbers
 *
 */

import 'dart:math';
import 'longnum/longnumclass.dart';
import 'format.dart';

add_master(longnum a, longnum b) {
  var ans = new longnum();
  var deci = add_deci(a.decimal, b.decimal);
  var carry_deci = 0;
  if (deci.first == 1) {
    carry_deci = 1;
    deci.removeAt(0);
  }
  ans.decimal = deci;
  ans.integer = add_int(a.integer, b.integer, carry: carry_deci);
  //ans = leadingzeros_nump(ans);
  return ans;
}

add_int(List a, List b, {int carry = 0, int power = 15}) {
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
  ans.removeAt(0);
  d = leadingzeroslist(d);
  return ans;
}

add_deci(List a, List b) {
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
    var c_place_size = c[i].toString().length;
    var d_place_size = d[i].toString().length;
    var POWER = pow(10, c_place_size);
    if (d_place_size < c_place_size) {
      d[i] *= pow(10, c_place_size - d_place_size);
    }
    ans[0] = (c[i] + d[i] + carry) % POWER;
    carry = ((c[i] + d[i] + carry) / POWER).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans.removeAt(0);
  if (carry == 1) {
    ans.insert(0, 1);
  }
  return ans;
}
