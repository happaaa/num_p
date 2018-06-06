import 'dart:math';
import 'num_p.dart';
import 'format.dart';
import 'add.dart';
import 'subtract.dart';

/*
 * to be fixed:
 * work with decimals (not sure)
 * work with negative numbers
 * fixed multi_int and multi functions to give proper output when given large numbers
 * clean up code
 */



// long multiplication with the new num_p class
// anything smaller than 7 digits
long_multi(num_p a, num_p b) {
  const BASE = 10;
  var c = new num_p();
  var bk = a.value.length;
  var bm = b.value.length;
  var q = 0;
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      var t = c.value[i + j] + q + a.value[bk - i - 1] * b.value[bm - j - 1];
      c.value[i + j] = t % BASE;
      q = (t / BASE).floor();
      c.value.add(0);
    }
    c.value[i + bm] = q;
    q = 0;
  }
  print(c.value);
}


karatsuba(num_p a, num_p b) => karatsuba_int(a.value, b.value);

karatsuba_int(List a, List b, {int power = 15}) {
  var a_size = a.length;
  var b_size = b.length;
  var max_size = max(a_size, b_size);
  int i = 0;

  if (max_size == 1) {
    return multi(a, b, power: power);
  }

  while (max_size > pow(2, i)) {
    i++;
  }
  int power_2 = pow(2, i - 1).toInt();

  var a0 = a.sublist(0, power_2);
  var a1 = a.sublist(power_2, a.length);
  var b0 = b.sublist(0, power_2);
  var b1 = b.sublist(power_2, b.length);
  //print(a0);
  //print(a1);
  //print(b0);
  //print(b1);
  var t1 = karatsuba_int(a1, b1, power: power);
  var t2 = karatsuba_int(a0, b0, power: power);
  var t3 = karatsuba_int(add_int(a0, a1, power: power), add_int(b0, b1, power: power), power: power);
  var t4 = subtract_int(subtract_int(t3, t2, power: power), t1, power: power);
  //print("ans: $t1 $t4 $t2");

  for (int i = 0; i < power_2; i++) {
    t4.add(0);
  }
  for (int i = 0; i < power_2 * 2; i++) {
    t2.add(0);
  }
  var ans0 = add_int(t1, t4, power: power);
  var ans = add_int(ans0, t2, power: power);
  //print('ans : $ans');
  return ans;
}

multi(List a, List b, {int power = 15}) {
  final BASE = pow(10, power);
  var c = [0];
  var d = [0];
  var bk = a.length;
  var bm = b.length;
  var q = 0;
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      var t = c[i + j] + q + a[bk - i - 1] * b[bm - j - 1];
      c[i + j] = t % BASE;
      q = (t / BASE).floor();
      c.add(0);
    }
    c[i + bm] = q;
    q = 0;
  }
  c = c.reversed.toList();
  c = leadingzeroslist(c);
  return c;
}

multi_small(num a, num b) {
  //final BASE = pow(10, 15);
  var size = max(a.toString().length, b.toString().length);
  if (size > 7) {
    var alist = new List(3);
    var blist = new List(3);

    alist[2] = a % pow(10, 7);
    alist[1] = (a % pow(10, 14) - alist[2]) ~/ pow(10, 7);
    alist[0] = a ~/ pow(10, 14);
    blist[2] = b % pow(10, 7);
    blist[1] = (b % pow(10, 14) - blist[2]) ~/ pow(10, 7);
    blist[0] = b ~/ pow(10, 14);
    print(alist);
    print(blist);

  }
  else {
    return a * b;
  }
}
