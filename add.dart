import 'dart:math';
import 'package:num_p/src/num_p.dart';
import 'format.dart';

/*
 * 6.5.18 made into seperate function for other programs
 * to be done:
 * make more concise
 * work with negative numbers
 *
 */
add_master(num_p a, num_p b) {
  var ans = new num_p();
  var deci = add_deci(a.decimal, b.decimal);
  var carry_deci = 0;
  if (deci.first == 1) {
    carry_deci = 1;
    deci.removeAt(0);
  }
  ans.decimal = deci;
  ans.value = add_int(a.value, b.value, carry: carry_deci);
  ans = leadingzeros_nump(ans);
  return ans;
}

add_int(List a, List b, {int carry = 0, int power = 15}) {
  final BASE = pow(10, power);
  var ans = [0];
  var size = max(a.length, b.length);
  var c = size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;
  var place;

  for (int i = 0; i < size - d_length; i++) {
    d.insert(0, 0);
  }
  //print('c: $c');
  //print('d: $d');
  for (int i = 0; i < size; i++) {
    place = c.length - i - 1;
    ans[0] = (c[place] + d[place] + carry) % BASE;
    carry = ((c[place] + d[place] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('carry: $carry');
    //print('ANS: $ans');
  }
  if (carry == 1) {
    ans[0] = 1;
  }
  ans.removeAt(0);
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
  for (int i = 0; i < size; i++) {
    var place = c.length - i - 1;
    var c_place_size = c[place].toString().length;
    var d_place_size = d[place].toString().length;
    var POWER = pow(10, c_place_size);
    if (d_place_size < c_place_size) {
      d[place] *= pow(10, c_place_size - d_place_size);
    }
    ans[0] = (c[place] + d[place] + carry) % POWER;
    carry = ((c[place] + d[place] + carry) / POWER).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans.removeAt(0);
  if (carry == 1) {
    ans.insert(0, 1);
  }
  return ans;
}
