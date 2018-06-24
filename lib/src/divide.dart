/*
 * division function for longnum
 *
 * wip:
 * burnikel-ziegler division (dependent on +/- negative numbers)
 * clean up
 * decimal division
 *
 * division only works when divisor is half of 10^power
 */

import 'dart:math';
import 'longnum/longnumclass.dart';
import 'add.dart';
import 'subtract.dart';
import 'multiply.dart';
import 'compare.dart';
import 'format.dart';



divmaster(Longnum a, Longnum b) {
  var ans = new Longnum();
  var a_list = new List.from(a.integer)..addAll(a.decimal);
  var b_list = new List.from(b.integer)..addAll(b.decimal);
  var dec_len = a.decimal.length + b.decimal.length;

  var size = max(a.decimal.length, b.decimal.length);
  var a_length = a.decimal.length;
  var b_length = b.decimal.length;
  if (a_length == size) {
    for (var i = b_length; i < size; i++) {
      a.decimal.add(0);
    }
  }
  else if (b_length == size) {
    for (var i = a_length; i < size; i++) {
      a.decimal.add(0);
    }
  }


  if (a == b) {
    ans.integer = [1];
  }
  else if (max(a_list.length, b_list.length) < 1000) {
    var quotient = long_div(a_list, b_list);
    ans.integer = quotient[0];

    for (var i = 0; i < dec_len; i++) {
      quotient[1].add(0);
      quotient = long_div(quotient[1], b_list);
      ans.decimal.add(quotient[0][0]);
    }
    //ans.decimal = quotient.sublist(quotient.length - dec_len, quotient.length);
    trailingzeroslist(ans.decimal);
    ans.decimal.removeAt(0);
    leadingzeroslist(ans.integer);
  }
  else {
    var quotient = two_by_one(a_list, b_list);
    print('zieglerr quotient: $quotient');
    quotient = long_div(a_list, b_list);
    print('long div quotient: $quotient');
  }

  return ans;
}


/*
 * limitations:
 * integer only
 * denominator has to be at least half of 10^power - FIXED
 * remainder is too large, is a remainder of the modified divisor - FIXED
 * a little slow
 */
long_div(List a, List b, [int power = 15]) {
  final BASE = pow(10, power);
  var constant = 1; // regulating divisor to be half of 10^power
  var c = a;
  var d = b;
  if (b[0] < BASE / 2) {
    constant = ((BASE / 2) / b[0]).ceil();
    a = multifull(a, [constant]);
    b = multifull(b, [constant]);
  }
  //print('div a: $a');
  //print('div b: $b');
  if (a.length < b.length) return [[0], c];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [[0], c];
    else return [[1], subtract_int(c, d, power: power)];
  }
  if (a.length == b.length + 1) {
    var result = long_div_sub(a, b, power);
    var remainder = long_div(result[1], [constant], power);
    return [result[0], remainder[0]];
  }
  var bm = a.length - b.length - 1;
  var a_prime = a.sublist(0, a.length - bm);
  var s = a.sublist(a.length - bm, a.length);
  //print('a_prime: $a_prime');
  var prime = long_div_sub(a_prime, b, power); // somehow adds a 0 in front of b - FIXED
  for (var i = 0; i < bm; i++) {
    prime[1].add(0);
  }
  //print('prime: $prime');
  //print('s: $s');
  var div = long_div(add_int(prime[1], s, power: power), b, power);

  for (var i = 0; i < bm; i++) {
    prime[0].add(0);
  }
  var remainder = long_div(div[1], [constant], power);
  //print('div: $div');
  return [add_int(prime[0], div[0], power: power), remainder[0]];
}

long_div_sub(List a, List b, [int power = 15]) {
  const BASE = 5;
  //print('a: $a');
  //print('new b: $b');
  if (a[0] > b[0]) {
    a = subtract_int(a, multifull(b, [1, 0]), power: power);
    var ans = long_div_sub(a, b, power);
    ans[0].insert(0, 1);
    return [ans[0], ans[1]];
  }
  var a_msb = [a[0], a[1]];
  var b_msb = [b[0]];

  var array = [];
  var b_msb_master = b_msb;
  while (compare_list(a_msb, b_msb_master) != 0) {
    var multiple;
    for (multiple = 0; compare_list(a_msb, multifull(b_msb_master, [BASE])) != 0; multiple++) {
      b_msb_master = multifull(b_msb_master, [BASE]);
      //print('b multiple ${multiple + 1}: $b_msb_master');
    }
    a_msb = subtract_int(a_msb, b_msb_master, power: power);
    b_msb_master = b_msb;
    array.add(multiple);
  }
  //print('array: $array');
  //var iteration = 0;
  var q = 0;
  for (var i = 0; i < array.length; i++) {
    q += pow(BASE, array[i]);
    //iteration += array[i];
  }
  //print(iteration);
  //print(q);
  var t = multifull([q], b);
  while (compare_list(t, a) == 1) {
    q -= 1;
    t = subtract_int(t, b, power: power);
  }
  t = subtract_int(a, t, power: power);
  //print(q);
  //print('t: $t');
  return [[q], t];
}




/*
 * Burnikel-Ziegler division
 * Limitations:
 * divisor must have an even number of limbs
 * integer only
 */
two_by_one(List a, List b, [int power = 15]) {
  //final BASE = pow(10, power);
  print('2_1');
  a = leadingzeroslist(a);

  if (b.length == 1) {
    return long_div(a, b, power);
  }

  //if (b.length.isOdd) b.insert(0, 0);

  var a_size = a.length;
  var size = b.length;
  var num_a = new List(4);
  var num_b = new List(2);

  for (var i = a_size; i < size * 2; i++) {
    a.insert(0, 0);
  }

  num_b[0] = b.sublist(size ~/ 2, size);
  num_b[1] = b.sublist(0, size ~/ 2);

  num_a[3] = a.sublist(0, size ~/ 2);
  num_a[2] = a.sublist(size ~/ 2, size);
  num_a[1] = a.sublist(size, size ~/ 2 * 3);
  num_a[0] = a.sublist(size ~/ 2 * 3, a.length);

  print('num_a: $num_a');
  print('num_b: $num_b');
  var dividendq1 = new List.from(num_a[3])..addAll(num_a[2])..addAll(num_a[1]);
  print('dividendq1: $dividendq1');
  var q1 = three_by_two(dividendq1, b, power);
  var dividendq2 = new List.from(q1[1])..addAll(num_a[0]);
  print('dividendq2: $dividendq2');
  var q2 = three_by_two(dividendq2, b, power);
  print('q1: $q1');
  print('q2: $q2');
  var quotient = new List.from(q1[0])..addAll(q2[0]);
  var remainder = q2[1];

  print('final 2_1: $quotient and remainder $remainder');
  return [quotient, remainder];
}

three_by_two(List a, List b, [int power = 15]) {
  //final BASE = pow(10, power);
  print('3_2');
  a = leadingzeroslist(a);

  var a_size = a.length;
  var size = b.length ~/ 2;
  var num_a = new List(3);
  var num_b = new List(2);

  for (var i = a_size; i < size * 3; i++) {
    a.insert(0, 0);
  }

  num_a[2] = a.sublist(0, size);
  num_a[1] = a.sublist(size, size * 2);
  num_a[0] = a.sublist(size * 2, size * 3);

  num_b[0] = b.sublist(size, size * 2);
  num_b[1] = b.sublist(0, size);
  print('num_a: $num_a');
  print('num_b: $num_b');

  var q_hat, r_one;
  if (compare_list(num_a[2], num_b[1]) == 0) {
    var dividend2_1 = new List.from(num_a[2])..addAll(num_a[1]);
    print('2_1 input: $dividend2_1 and ${num_b[1]}');
    var result = two_by_one(dividend2_1, num_b[1], power);
    print('results: $result');
    q_hat = result[0];
    r_one = result[1];
  }
  else {
    q_hat = [1];
    for (var i = 0; i < size; i++) {
      q_hat.add(0);
    }
    q_hat = subtract_int(q_hat, [1], power: power);
    r_one = subtract_int(num_a[2], num_b[1], power: power);
    r_one.addAll(add_int(num_a[1], num_b[1], power: power));
  }
  print('r_one: $r_one');
  var r_hat = new List.from(r_one)..addAll(num_a[0]);
  print('r_hat proto: $r_hat');
  r_hat = div_sub_helper(r_hat, multifull(q_hat, num_b[0]), power);
  print('r_hat final: $r_hat');

  if (r_hat[0] == -1) {
    r_hat.remove(-1);
    while (r_hat[0] != -1) {
      r_hat = div_sub_helper(r_hat, b, power);
      q_hat = subtract_int(q_hat, [1], power: power);
    }
    r_hat.remove(-1);
  }
  print('final 3_2: $q_hat and remainder $r_hat');
  return [q_hat, r_hat];
}

div_sub_helper(List a, List b, [int power = 15]) {
  final BASE = pow(10, power);
  var ans = [0];
  var size = max(a.length, b.length);
  var a_len = a.length;
  var b_len = b.length;
  var carry = 0;

  if (a_len == size) {
    for (var i = b_len; i < size; i++) {
      b.insert(0, 0);
    }
  }
  else if (b_len == size) {
    for (var i = a_len; i < size; i++) {
      a.insert(0, 0);
    }
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
  if (carry == -1) {
    for (var i = 0; i < ans.length; i++) {
      ans[i] = BASE - ans[i] - 1;
      if (ans[i] == 0) {
        ans[i] = 0;
        ans[i - 1] += 1;
      }
      else {
        ans[i] = BASE - ans[i] - 1;
      }
    }
    //print(ans);
    //if (ans.last == BASE - 1) {
    //  ans[ans.length - 1] = 0;
    //  ans[ans.length - 2] += 1;
    //}
    //else {
    //  ans[ans.length - 1] += 1;
    //}
    ans.insert(0, -1);
  }
  return ans;
}




// Jebelean exact division  algorithm (can't find anything on how exactly to do it)
exactdiv(List a, List b) {


}


barrettlist(List a, List b, List mu) { //  mu ~~ pow(BASE, a_size) / b
  var a1 = a.sublist(0, a.length - b.length + 1);
  print('a1: $a1');
  var qk = multifull(a1, mu).sublist(0, b.length - 1);
  print('first qk: $qk');
  var rk = div_sub_helper(a, multifull(b, qk));
  print('first rk: $rk');
  if (rk[0] == -1) {
    rk.remove(-1);
    while (rk[0] != -1) {
      rk = div_sub_helper(rk, b);
      qk = subtract_int(qk, [1]);
      print('lq: $qk and r: $rk');
    }
    rk.remove(-1);
  }
  while (compare_list(rk, b) != 0) {
      rk = div_sub_helper(rk, b);
      qk = add_int(qk, [1]);
      print('q: $qk and r: $rk');
  }
  return [qk, rk];

}


newtonlist(List number, num iteration) {
  var i = 1;
  var zk = long_div([1, 0], number)[0];
  var sk, tk, uk, wk;
  for (i; i < iteration; i++) {
    sk = squaring(zk);
    tk = number; // truncate
    uk = multifull(tk, sk); // truncate
    wk = multifull(zk, [2]);
    zk = subtract_int(wk, uk);
    print('zk: $zk');
  }
  return zk;
}
