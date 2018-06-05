import 'dart:math';
import 'num_p.dart';
import 'format.dart';

void main() {
  var common = new num_p.string('4000000000000005.005');
  //print(common.value);
  //print(common.decimal);

  //long_multi(c, c);
  //multi(c, c);
  //print(d.value);
  //karatsuba([1, 2, 3, 4], [5, 6, 7, 8]);
  var c = [1, 2, 3, 4];
  var d = [5, 6, 7, 8];
  //print(c + 5);
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
  c = leadingzeros(c);
  print(c.value);
}


karatsuba_interim(num_p a, num_p b) => karatsuba(a.value, b.value);

karatsuba(List a, List b) {
  var a_size = a.length;
  var b_size = b.length;
  var max_size = max(a_size, b_size);

  bool limb = false;
  if (max_size == 1) {
    limb = true;
  }

  int i = 0;
  while (max_size > pow(2, i)) {
    i++;
  }

  int power = pow(2, i - 1).toInt();

  var a0 = a.getRange(power, a.length).toList();
  var a1 = a.getRange(0, power).toList();
  var b0 = b.getRange(power, b.length).toList();
  var b1 = b.getRange(0, power).toList();

  var t1 = karatsuba(a1, b1);
  var t2 = karatsuba(a0, b0);




  var t3 = karatsuba(a0 + a1, b0 + b1);
  var t4 = t3 - t2 - t1;

  //print(a0);
  //print(a1);

}
