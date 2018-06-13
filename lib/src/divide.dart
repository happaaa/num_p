/*
 * division function for num_p
 *
 * wip:
 * burnikel-ziegler division (dependent on +/- negative numbers)
 * clean up
 * decimal division
 */

import 'dart:math';
import 'class/num_p.dart';
import 'add.dart';
import 'subtract.dart';
import 'multiply.dart';
import 'compare.dart';
import 'format.dart';

long_divv(num_p a, num_p b) => long_div(a.integer, b.integer);

long_div(List a, List b, [int power = 15]) {
  //print('a: $a');
  //print('b: $b');
  if (a.length < b.length) return [[0], a];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [[0], a];
    else return [[1], subtract_int(a, b, power: power)];
  }
  if (a.length == b.length + 1) return long_div_sub(a, b, power);
  var bm = a.length - b.length - 1;
  var a_prime = a.sublist(0, a.length - bm);
  var s = a.sublist(a.length - bm, a.length);
  //print('a_prime: $a_prime');
  var prime = long_div_sub(a_prime, b, power); // somehow adds a 0 in front of b
  for (var i = 0; i < bm; i++) {
    prime[1].add(0);
  }
  //print('prime: $prime');
  //print('s: $s');
  var div = long_div(add_int(prime[1], s, power: power), b, power);

  for (var i = 0; i < bm; i++) {
    prime[0].add(0);
  }
  //print('div: $div');
  return [add_int(prime[0], div[0], power: power), div[1]];
}

long_div_sub(List a, List b, [int power = 15]) {
  final BASE = pow(10, power);
  var constant = 1;
  if (b[0] < BASE / 2) {
    constant = ((BASE / 2) / b[0]).ceil();
    b = multi_int(b, [constant], power: power);
  }
  //print('a: $a');
  //print('new b: $b');
  //print('constant: $constant');
  if (a[0] > b[0]) {
    a = subtract_int(a, multi_int(b, [1, 0], power: power), power: power);
    var ans = long_div_sub(a, b, power);
    ans[0].insert(0, 1);
    return [ans[0], ans[1]];
  }
  var a_msb = [a[0], a[1]];
  var b_msb = [b[0]];
  var two_multi = 0, adding = 0;
  for (two_multi; compare_list(a_msb, multi_int(b_msb, [2], power: power)) != 0; two_multi++) {
    b_msb = multi_int(b_msb, [2], power: power);
    //print('b multiple ${two_multi + 1}: $b_msb');
  }
  for (adding; compare_list(a_msb, add_int(b_msb, [b[0]], power: power)) != 0; adding++) {
    b_msb = add_int(b_msb, [b[0]], power: power);
    //print('b adding ${adding + 1}: $b_msb');
  }
  //print('final multi: $two_multi and final adding: $adding');
  var q = add_int([pow(2, two_multi)], [adding]);
  var t = multi_int(q, b, power: power);
  while (compare_list(t, a) == 1) {
    q = subtract_int(q, [1]);
    t = subtract_int(t, b, power: power);
  }
  t = subtract_int(a, t, power: power);
  //print(q);
  //print('t: $t');
  /*if (constant != 1) {
    q = multi_int(q, [constant], power: power);
    t = subtract_int(a, t, power: power);
    print('new q: $q');
    print('new t: $t');
    var i = 0;
    while (compare_list(t, add_int(t, b, power: power)) != 0) {
      b_msb = add_int(b_msb, [b[0]], power: power)
    }

    q = add_int(q, [t[0] ~/ (b[0] / constant)], power: power);
    t = [t[0] % (b[0] ~/ constant)];
  }*/
  return [q, t];
}








two_by_one(List a, List b, [int power = 15]) {
  //final BASE = pow(10, power);
  print('2_1');
  a = leadingzeroslist(a);

  if (b.length == 1) {
    return long_div(a, b, power);
  }
  //if (a.length < b.length) return [0, a];
  //if (a.length == b.length) {
  //  if (a[0] < b[0]) return [0, a];
  //  else return [1, subtract_int(a, b, power: power)];
  //}
  //if (a.length == b.length + 1) return long_div_sub(a, b, power);

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
  var divisorq1 = new List.from(num_a[3])..addAll(num_a[2])..addAll(num_a[1]);
  print('divisorq1: $divisorq1');
  var q1 = three_by_two(divisorq1, b, power);
  var divisorq2 = new List.from(q1[1])..addAll(num_a[0]);
  print('divisorq2: $divisorq2');
  var q2 = three_by_two(divisorq2, b, power);
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

  num_b[1] = b.sublist(size, size * 2);
  num_b[0] = b.sublist(0, size);
  print('num_a: $num_a');
  print('num_b: $num_b');

  var q_hat, r_one;
  if (compare_list(num_a[2], num_b[1]) == 0) {
    var divisor2_1 = new List.from(num_a[2])..addAll(num_a[1]);
    print('2_1 input: $divisor2_1 and ${num_b[1]}');
    var result = two_by_one(divisor2_1, num_b[1], power);
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
  r_hat = subtract_int(r_hat, multi_int(q_hat, num_b[0], power: power), power: power);
  print('r_hat final: $r_hat');
  if (compare_list(r_hat, [0]) == 0) {
    r_hat = add_int(r_hat, b, power: power);
    q_hat = subtract_int(q_hat, [1], power: power);
  }
  if (compare_list(r_hat, [0]) == 0) {
    r_hat = add_int(r_hat, b, power: power);
    q_hat = subtract_int(q_hat, [1], power: power);
  }
  print('final 3_2: $q_hat and remainder $r_hat');
  return [q_hat, r_hat];
}
