import 'dart:math';
import 'lib/src/num_p.dart';
import 'multiply.dart';

long_div(List a, List b) {

}

long_div_sub(List a, List b) {
  final BASE = pow(10, 15);

  if (b[0] < BASE / 2) {
    var constant = ((BASE / 2) / b[0]).ceil();
    b[0] *= constant;
  }

  if (a[0] > b[0]) {
    a[0] -= b[0];
    var ans = long_div_sub(a, b);
    //return [ans[0].add(0);]
  }

  var a_msb = a[0];
  var b_msb = b[0] ~/ pow(10, 7);

  var q = a_msb ~/ b_msb;
  var t = multi_large([q], b);
  while (t > a) {
    q -= 1;
    t -= b;
  }
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
