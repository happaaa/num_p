import 'dart:math';
import 'lib/src/num_p.dart';
import 'format.dart';
import 'add.dart';
import 'subtract.dart';

/*
 * to be fixed:
 * work with decimals (not sure)
 * work with negative numbers
 * clean up code
 */

// long multiplication with the new num_p class
long_multi(num_p a, num_p b) {
  var c = new num_p();
  var bk = a.integer.length;
  var bm = b.integer.length;
  var q = [0];
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      //print('q: $q');
      //print('cval: ${c.integer[i + j]}');
      //print('aval: ${a.integer[bk - i - 1]}');
      //print('bval: ${b.integer[bm - j - 1]}');
      var t = add_int(add_int([c.integer[i + j]], q), multi(a.integer[bk - i - 1], b.integer[bm - j - 1]));
      //print('t: $t');
      c.integer[i + j] = t.last;
      //print('cval: ${[c.integer[i + j]]}');
      q = t.sublist(0, t.length - 1);
      c.integer.add(0);
    }
    c.integer[i + bm] = q.first;
    q = [0];
  }
  c.integer = c.integer.reversed.toList();
  c = leadingzeros_nump(c);
  //print(c.integer);
  return c;
}



karatsuba(num_p a, num_p b) => karatsuba_int(a.integer, b.integer);

karatsuba_int(List a, List b, [int power = 15]) {
  var a_size = a.length;
  var b_size = b.length;
  var max_size = max(a_size, b_size);
  int i = 0;

  if (max_size == 1) {
    return multi(a.first, b.first);
  }

  var c = max_size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;

  for (var i = 0; i < max_size - d_length; i++) {
    d.insert(0, 0);
  }

  while (max_size > pow(2, i)) {
    i++;
  }

  int power_2 = pow(2, i - 1).toInt();
  var c0 = c.sublist(0, power_2);
  var c1 = c.sublist(power_2, a.length);
  var d0 = d.sublist(0, power_2);
  var d1 = d.sublist(power_2, b.length);
  //print(c0);
  //print(c1);
  //print(d0);
  //print(d1);
  var t1 = karatsuba_int(c1, d1, power);
  var t2 = karatsuba_int(c0, d0, power);
  var t3 = karatsuba_int(add_int(c0, c1, power: power), add_int(d0, d1, power: power), power);
  //print('t3: $t3');
  var t4 = subtract_int(subtract_int(t3, t2, power: power), t1, power: power);
  //print("ans: $t1 $t4 $t2");

  for (int i = 0; i < power_2; i++) {
    t4.add(0);
  }
  for (int i = 0; i < power_2 * 2; i++) {
    t2.add(0);
  }
  var ans = add_int(add_int(t1, t4, power: power), t2, power: power);
  return ans;
}

multi(num a, num b) {
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
    var newlist = multi_large(alist, blist, power: 7);
    //print('newlist: $newlist');
    var ans = [0, 0];
    newlist = newlist.reversed.toList();
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

multi_large(List a, List b, {int power = 15}) {
  final BASE = pow(10, power);
  var c = [0];
  var bk = a.length;
  var bm = b.length;
  var q = 0;
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      var t = c[i + j] + q + a[bk - i - 1] * b[bm - j - 1];
      c[i + j] = t % BASE;
      //print('cval: ${c[i + j]}');
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
