import 'dart:math';
import 'num_p.dart';
import 'format.dart';
import 'add.dart';
import 'subtract.dart';

void main() {
  //var common = new num_p.string('4000000000000005.005');
  //print(common.value);
  //print(common.decimal);

  //print(karatsuba_recursive(100242, 123747));
  //multi_int([1, 23, 45], [1, 0, 0], power: 2);
  karatsuba_interim([1234, 56789], [9876, 54321], power: 5);
}

// long multiplication with the new num_p class
multi(num_p a, num_p b) {
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




long_multi(num_p a, num_p b) {
  var c = new num_p();
  for (int i  = 0; i < a.value.length; i++) {
    for (int j = 0; j < b.value.length; j++) {
      c.value[i + j] = c.value[i + j] + (a.value[a.value.length - i - 1] * b.value[b.value.length - j - 1]);
      if (c.value[i + j] >= 10) {
        var p = c.value[i + j] ~/ 10;
        i + j + 1 == c.value.length ? c.value.add(p) : c.value[i + j + 1] += p;
        c.value[i + j] -= p * 10;
      }
      else {
        c.value.add(0);
      }
    }
  }
  c = leadingzeros_nump(c);
  print(c.value);
}


karatsuba(num_p a, num_p b) => karatsuba_interim(a.value, b.value);

karatsuba_interim(List a, List b, {int power = 15}) {
  var a_size = a.length;
  var b_size = b.length;
  var max_size = max(a_size, b_size);

  bool limb = false;
  if (max_size == 1) {
    limb = true;
    return multi_int(a, b, power: power);
  }

  int i = 0;
  while (max_size > pow(2, i)) {
    i++;
  }
  print('i val: $i');

  int power_2 = pow(2, i - 1).toInt();

  var a0 = a.sublist(0, power_2);
  var a1 = a.sublist(power_2, a.length);
  var b0 = b.sublist(0, power_2);
  var b1 = b.sublist(power_2, b.length);
  print(a0);
  print(a1);
  print(b0);
  print(b1);

  var t1 = karatsuba_interim(a1, b1, power: power);
  var t2 = karatsuba_interim(a0, b0, power: power);

  var t3_0 = add_int(a0, a1, power: power);
  var t3_1 = add_int(b0, b1, power: power);
  var t3 = karatsuba_interim(t3_0, t3_1, power: power);

  var t4_0 = subtract_int(t3, t2, power: power);
  var t4 = subtract_int(t4_0, t1, power: power);

  print("ans: $t1 $t4 $t2");


  //var multiplier = [1]
  for (int i = 0; i < power_2; i++) {
    t4.add(0);
  }
  for (int i = 0; i < power_2 * 2; i++) {
    t2.add(0);
  }
  var ans0 = add_int(t1, t4, power: power);
  var ans = add_int(ans0, t2, power: power);
  print('ans : $ans');
  return ans;
}

multi_int(List a, List b, {int power = 15}) {
  final BASE = pow(10, power);
  var c = [0];
  var bk = a.length;
  var bm = b.length;
  var q = 0;
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      //print('lol: ${a[bk - i - 1]} ${b[bm - j - 1]}');
      var t = c[i + j] + q + a[bk - i - 1] * b[bm - j - 1];
      c[i + j] = t % BASE;
      q = (t / BASE).floor();
      //print('q: $q');
      c.add(0);
    }
    c[i + bm] = q;
    q = 0;
  }
  c = c.reversed.toList();
  c = leadingzeroslist(c);
  print(c);
  return c;
}



karatsuba_recursive(num a, num b) {
  var a_size = a.toString().length;
  var b_size = b.toString().length;
  var max_size = max(a_size, b_size);
  //var min_size = min(a_size, b_size);

  //print(max_size);
  //print('$a $b');

  if (max_size == 1) {
    return a * b;
  }

  int i = 0;
  for (i; i < 5; i++) {
    if (max_size <= pow(2, i)) {
      break;
    }
  }
  print('i val: $i');

  var a_list = [a ~/ pow(10, pow(2, i - 1)), a % pow(10, pow(2, i - 1))];
  var b_list = [b ~/ pow(10, pow(2, i - 1)), b % pow(10, pow(2, i - 1))];

  print(a_list);
  print(b_list);

  var t1 = karatsuba_recursive(a_list[1], b_list[1]);
  var t2 = karatsuba_recursive(a_list[0], b_list[0]);
  var t3 = karatsuba_recursive(a_list[0] + a_list[1], b_list[0] + b_list[1]);
  var t4 = t3 - t2 - t1;
  print("ans: $t1 $t4 $t2");
  //print('i val: $i');
  return t1 + pow(10, pow(2, i - 1)) * t4 + t2 * pow(10, pow(2, i));
}
