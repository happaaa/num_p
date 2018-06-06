import 'dart:math';
import 'num_p.dart';
import 'format.dart';

// works with decimals and new num_p class properly
// intending to make it simpler in the near future
// 6.5.18 made into seperate functions for others
add_master(num_p a, num_p b) {
  var ans = new num_p();
  var deci = add_deci(a.decimal, b.decimal);
  var carry = 0;
  if (deci[0] == 1) {
    carry = 1;
    deci.removeAt(0);
  }
  ans.decimal = deci;
  ans.value = add_int(a.value, b.value, carry);
  ans = leadingzeros(ans);
  return ans;
}

add_int(List a, List b, [int carry = 0]) {
  final BASE = pow(10, 15);
  var ans = [0];
  var size = max(a.length, b.length);
  var c = size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;
  var place;

  for (int i = 0; i < size - d_length; i++) {
    d.insert(0, 0);
  }
  //print('c: $c');
  //print('d: $d');
  for (int i = 0; i < size; i++) {
    place = c.length - i - 1;
    ans[0] = (c[place] + d[place] + carry) % BASE;
    carry = ((c[place] + d[place] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  return ans;
}

add_deci(List a, List b) {
  //final BASE = pow(10, 15);
  var ans = [0];
  var size = max(a.length, b.length);
  var c = size == a.length ? a : b;
  if (a.length == b.length) {
    c = a[a.length - 1].toString().length > b[b.length - 1].toString().length ? a : b;
  }
  var d = c == a ? b : a;
  var d_length = d.length;
  var carry = 0;

  for (int i = 0; i < size - d_length; i++) {
    d.add(0);
  }
  //print('c: $c');
  //print('d: $d');
  for (int i = 0; i < size; i++) {
    var place = c.length - i - 1;
    var c_place_size = c[place].toString().length;
    var d_place_size = d[place].toString().length;
    var POWER = pow(10, c_place_size);
    if (d_place_size < c_place_size) {
      d[place] *= pow(10, c_place_size - d_place_size);
    }
    ans[0] = (c[place] + d[place] + carry) % POWER;
    carry = ((c[place] + d[place] + carry) / POWER).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  if (carry == 1) {
    ans.insert(0, 1);
  }
  return ans;
}
