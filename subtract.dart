import 'dart:math';
import 'lib/src/num_p.dart';
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
  ans.integer = subtract_int(parts[0], parts[1], carry: carry_deci);
  ans = leadingzeros_nump(ans);
  return ans;
}

compare(num_p a, num_p b) {
  var q;
  var sign = false;
  if (a.integer.length > b.integer.length) {
    q = a.integer;
  }
  else if (a.integer.length < b.integer.length) {
    q = b.integer;
    sign = true;
  }
  else {
    for (int i = 0; i < a.integer.length; i++) {
      if (a.integer[i] > b.integer[i]) {
        q = a.integer;
        break;
      }
      else if (b.integer[i] > a.integer[i]) {
        q = b.integer;
        sign = true;
        break;
      }
      else if (i == a.integer.length - 1) {
        q = a.integer;
      }
    }
  }
  var w = q == a.integer ? b.integer : a.integer;
  var e = q == a.integer ? a.decimal : b.decimal;
  var r = q == a.integer ? b.decimal : a.decimal;
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
  for (int i = size - 1; i >= 0; i--) {
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans = leadingzeroslist(ans);
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
    for (var i = b_length; i < size; i++) {
      b.add(0);
    }
  }
  else if (b_length == size) {
    for (var i = a_length; i < size; i++) {
      a.add(0);
    }
  }
  //print('a: $a');
  //print('b: $b');
  for (var i = size; i >= 0; i--) {
    a[i] *= BASE ~/ pow(10, a[i].toString().length);
    b[i] *= BASE ~/ pow(10, b[i].toString().length);
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
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
