import 'dart:math';
import 'package:num_p/src/num_p.dart';
import 'format.dart';

/*
 * to be done:
 * make more concise
 * work with negative numbers
 *
 */

subtract_master(num_p a, num_p b) {
  var ans = new num_p();
  var parts = compare(a, b);
  var deci = subtract_deci(parts[2], parts[3]);
  var carry_deci = 0;
  if (deci.first == 1) {
    carry_deci = -1;
    deci.removeAt(0);
  }
  ans.neg = parts[4] ? true : false;
  ans.decimal = deci;
  ans.value = subtract_int(parts[0], parts[1], carry: carry_deci);
  ans = leadingzeros_nump(ans);
  return ans;
}

compare(num_p a, num_p b) {
  var q;
  var sign = false;
  if (a.value.length > b.value.length) {
    q = a.value;
  }
  else if (a.value.length < b.value.length) {
    q = b.value;
    sign = true;
  }
  else {
    for (int i = 0; i < a.value.length; i++) {
      if (a.value[i] > b.value[i]) {
        q = a.value;
        break;
      }
      else if (b.value[i] > a.value[i]) {
        q = b.value;
        sign = true;
        break;
      }
      else if (i == a.value.length - 1) {
        q = a.value;
      }
    }
  }
  var w = q == a.value ? b.value : a.value;
  var e = q == a.value ? a.decimal : b.decimal;
  var r = q == a.value ? b.decimal : a.decimal;
  return [q, w, e, r, sign];
}

subtract_int(List a, List b, {int carry = 0, int power = 15}) {
  final BASE = pow(10, power);
  var ans = [0];
  var size = a.length;
  var b_length = b.length;

  for (int i = 0; i < size - b_length; i++) {
    b.insert(0, 0);
  }
  //print('a: $a');
  //print('b: $b');
  for (int i = 0; i < size; i++) {
    var place = a.length - i - 1;
    ans[0] = (a[place] - b[place] + carry) % BASE;
    carry = ((a[place] - b[place] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans.removeAt(0);
  return ans;
}

subtract_deci(List a, List b) {
  final BASE = pow(10, 15);
  var ans = [0];
  var size = max(a.length, b.length);
  var carry = 0;
  var a_length = a.length;
  var b_length = b.length;

  if (a_length == size) {
    for (int i = 0; i < size - b_length; i++) {
      b.add(0);
    }
  }
  else if (b_length == size) {
    for (int i = 0; i < size - a_length; i++) {
      a.add(0);
    }
  }
  //print('a: $a');
  //print('b: $b');
  for (int i = 0; i < size; i++) {
    var place = a.length - i - 1;
    a[place] *= BASE ~/ pow(10, a[place].toString().length);
    b[place] *= BASE ~/ pow(10, b[place].toString().length);
    ans[0] = (a[place] - b[place] + carry) % BASE;
    carry = ((a[place] - b[place] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans.removeAt(0);
  if (carry == -1) {
    for (int i = 0; i < ans.length - 1; i++) {
      ans[i] = BASE - ans[i] - 1;
    }
    ans.last = BASE - ans.last;
    ans.insert(0, 1);
  }
  //print('final ans: $ans');
  return ans;
}
