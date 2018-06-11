import 'dart:math';
import 'add.dart';
import 'subtract.dart';
import 'multiply.dart';
import 'compare.dart';

long_div(List a, List b, [int power = 15]) {
  final BASE = pow(10, power);
  print('a: $a');
  print('b: $b');

  if (a.length < b.length) return [0, a];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [0, a];
    else return [1, subtract_int(a, b, power: power)];
  }
  if (a.length == b.length + 1) return long_div_sub(a, b, power);
  print('new3 b: $b');
  var bm = a.length - b.length - 1;
  var a_prime = a.sublist(0, a.length - bm);
  var s = a.sublist(a.length - bm, a.length);
  print('new2 b: $b');
  var prime = long_div_sub(a_prime, b, power); // somehow adds a 0 in front of b
  print('new4 b: $b');
  for (var i = 0; i < bm; i++) {
    prime[1].add(0);
  }
  print('prime: $prime');
  print('s: $s');
  print('new b: $b');
  var div = long_div(add_int(prime[1], s, power: power), b, power);

  for (var i = 0; i < bm; i++) {
    prime[0].add(0);
  }
  print('div: $div');


  return [add_int(prime[0], div[0], power: power), div[1]];
}

long_div_sub(List a, List b, [int power = 15]) {
  final BASE = pow(10, power);
  var d = b;
  var constant = 1;
  if (b[0] < BASE / 2) {
    constant = ((BASE / 2) / b[0]).ceil();
    b = multi_list(b, [constant], power: power);
  }
  //print('a: $a');
  //print('new b: $b');
  //print('constant: $constant');

  if (a[0] > b[0]) {
    a[0] -= b[0];
    var ans = long_div_sub(a, b, power);
    ans[0].insert(0, 1);
    return [ans[0], ans[1]];
  }

  var a_msb = [a[0], a[1]];
  var b_msb = [b[0]];

  var two_multi = 0, adding = 0;
  for (two_multi; compare_list(a_msb, multi_list(b_msb, [2], power: power)) != 0; two_multi++) {
    b_msb = multi_list(b_msb, [2], power: power);
    //print('b multiple ${two_multi + 1}: $b_msb');
  }
  for (adding; compare_list(a_msb, add_int(b_msb, [b[0]], power: power)) != 0; adding++) {
    b_msb = add_int(b_msb, [b[0]], power: power);
    //print('b adding ${adding + 1}: $b_msb');
  }

  //print('final multi: $two_multi and final adding: $adding');
  //print(pow(2, two_multi) + adding);

  var q = add_int([pow(2, two_multi)], [adding]);
  var t = multi_list(q, b, power: power);

  while (compare_list(t, a) == 1) {
    q = subtract_int(q, [1]);
    t = subtract_int(t, b, power: power);
  }

  t = subtract_int(a, t, power: power);

  //print(q);
  //print('t: $t');
  /*if (constant != 1) {
    q = multi_list(q, [constant], power: power);
    t = subtract_int(a, t, power: power);
    print('new q: $q');
    print('new t: $t');
    var i = 0;
    while (compare_list(t, add_int(t, d, power: power)) != 0) {
      b_msb = add_int(b_msb, [b[0]], power: power)
    }

    q = add_int(q, [t[0] ~/ (b[0] / constant)], power: power);
    t = [t[0] % (b[0] ~/ constant)];
  }*/

  return [q, t];
}








two_by_one(List a, List b) {
  final BASE = pow(10, 15);

  if (b.length == 1) {

  }

  var num_a = new List(4);
  var num_b = new List(2);
  num_a[3] = a.sublist(0, 4);
  num_a[1] = a.sublist(a.length - b.length, a.length - (b.length ~/ 2));
  num_a[0] = a.sublist(a.length - (b.length ~/ 2), a.length);
}

three_by_two(List a, List b) {

}
