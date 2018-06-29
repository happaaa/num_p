import 'dart:math';

List lead0(List number) {
  var k = number.length;
  for (var u = 1; u < k && number.first == 0; u++) {
    number.removeAt(0);
  }
  return number;
}

List trail0(List number) {
  while (number.length != 1 && number.last == 0) {
    number.removeAt(number.length - 1);
  }
  return number;
}

num compare_list(List a, List b) {
  a = lead0(a);
  b = lead0(b);
  if (a.length > b.length) return 1;
  else if (a.length < b.length) return 0;
  else {
    for (var i = 0; i < a.length; i++) {
      if (a[i] > b[i]) return 1;
      if (a[i] < b[i]) return 0;
    }
    return 2;
  }
}

List add_int(List a, List b, {int carry = 0, int power = 15}) {
  final BASE = pow(10, power);
  var ans = [0];
  var size = max(a.length, b.length);
  var c = size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;

  for (var i = 0; i < size - d_length; i++) {
    d.insert(0, 0);
  }
  //print('c: $c');
  //print('d: $d');
  for (var i = size - 1; i >= 0; i--) {
    ans[0] = (c[i] + d[i] + carry) % BASE;
    carry = ((c[i] + d[i] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('carry: $carry');
    //print('ANS: $ans');
  }
  if (carry == 1) {
    ans[0] = 1;
  }
  ans = lead0(ans);
  d = lead0(d);
  return ans;
}

List add_deci(List a, List b) {
  final BASE = pow(10, 15);
  var ans = [0];
  var size = max(a.length, b.length);
  var c = size == a.length ? a : b;
  if (a.length == b.length) {
    c = a.last.toString().length > b.last.toString().length ? a : b;
  }
  var d = c == a ? b : a;
  var d_length = d.length;
  var carry = 0;

  for (int i = 0; i < size - d_length; i++) {
    d.add(0);
  }
  //print('c: $c');
  //print('d: $d');
  for (int i = size - 1; i >= 0; i--) {
    ans[0] = (c[i] + d[i] + carry) % BASE;
    carry = ((c[i] + d[i] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans.removeAt(0);
  if (carry == 1) {
    ans.insert(0, 1);
  }
  d = trail0(d);
  return ans;
}

List subtract_int(List a, List b, {int carry = 0, int power = 15}) {
  final BASE = pow(10, power);
  var ans = [0];
  var size = a.length;
  var b_length = b.length;

  for (int i = 0; i < size - b_length; i++) {
    b.insert(0, 0);
  }
  //print('int a: $a');
  //print('int b: $b');
  for (int i = size - 1; i >= 0; i--) {
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('int ans: $ans');
  }
  ans = lead0(ans);
  b = lead0(b);
  return ans;
}

List subtract_deci(List a, List b) {
  final BASE = pow(10, 15);
  var ans = [0];
  var size = max(a.length, b.length);
  var carry = 0;
  //var a_length = a.length;
  //var b_length = b.length;

  if (a.length == size) {
    for (var i = b.length; i < size; i++) {
      b.add(0);
    }
  }
  else if (b.length == size) {
    for (var i = a.length; i < size; i++) {
      a.add(0);
    }
  }
  //print('a: $a');
  //print('b: $b');
  for (var i = size - 1; i >= 0; i--) {
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
    ans.insert(0, 0);
    //print('ans: $ans');
  }
  ans.removeAt(0);
  carry == -1 ? ans.insert(0, -1) : ans.insert(0, 0);
  a = trail0(a);
  b = trail0(b);
  return ans;
}

List multifull(List a, List b) {
  var ans = [0];
  var bk = a.length;
  var bm = b.length;
  var q = [0];
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      //print('Q: $q');
      //print('a[${bk - 1 - i}]: ${a[bk - i - 1]}');
      //print('b[${bm - 1 - j}]: ${b[bm - j - 1]}');
      var t = add_int(add_int([ans[i + j]], q), multinum(a[bk - i - 1], b[bm - j - 1]));
      //print('t: $t');
      ans[i + j] = t.last;
      q = t.sublist(0, t.length - 1);
      if (q.isEmpty) {
        q.add(0);
      }
      ans.add(0);
    }
    ans[i + bm] = q.first;
    q = [0];
  }
  ans = ans.reversed.toList();
  ans = lead0(ans);
  return ans;
}

List multinum(num a, num b) {
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
    var newlist = [0];
    var bk = alist.length;
    var bm = blist.length;
    var q = 0;
    for (int i  = 0; i < bk; i++) {
      for (int j = 0; j < bm; j++) {
        var t = newlist[i + j] + q + alist[bk - i - 1] * blist[bm - j - 1];
        newlist[i + j] = t % BASE;
        q = (t / BASE).floor();
        newlist.add(0);
      }
      newlist[i + bm] = q;
      q = 0;
    }
    newlist = trail0(newlist);
    var ans = [0, 0];
    //print('newlist: $newlist');
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
    ans = lead0(ans);
    return ans;
  }
  else {
    return [a * b];
  }
}

List squaring(List number) {
  var ans = [0, 0];
  var q = [0];
  for (var i = 0; i < number.length - 1; i++) {
    for (var j = i + 1; j < number.length; j++) {
      //print('number: ${number[number.length - i - 1]} and other number: ${number[number.length - j - 1]}');
      var product = multinum(number[number.length - i - 1], number[number.length - j - 1]);
      product = multifull(product, [2]);
      //print('product: $product');
      var t = add_int(add_int([ans[i + j]], q), product);
      ans[i + j] = t.last;
      q = t.sublist(0, t.length - 1);
      if (q.isEmpty) {
        q.add(0);
      }
      ans.add(0);
      //print('product ans: $ans');
      //print('q: $q');
    }
    ans[i + number.length] = q.first;
    q = [0];
  }
  ans = ans.reversed.toList();
  lead0(ans);
  //print('ans before squares: $ans');
  for (var i = 0; i < number.length; i++) {
    var square = multinum(number[number.length - i - 1], number[number.length - i -1]);
    for (var j = 0; j < i * 2; j++) {
      square.add(0);
    }
    //print('square: $square');
    ans = add_int(ans, square);
    //print('square ans: $ans');
  }
  //print(ans);
  return ans;
}

/*
 * Karatsuba algorithm
 */
List karatsuba(List a, List b, [int power = 15]) {
  var max_size = max(a.length, b.length);
  int i = 0;
  if (max_size == 1) {
    return multinum(a.first, b.first);
  }

  var c = max_size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;

  for (var i = 0; i < max_size - d_length; i++) {
    d.insert(0, 0);
  }
  //print('c? $c');
  //print('d: $d');
  while (max_size > pow(2, i)) {
    i++;
  }

  int power_2 = pow(2, i - 1).toInt();
  var c0 = c.sublist(0, power_2);
  var c1 = c.sublist(power_2, a.length);
  var d0 = d.sublist(0, power_2);
  var d1 = d.sublist(power_2, b.length);
  //print('c0: $c0);
  //print('c11: $c1);
  //print('d0: $d0);
  //print('d11: $d1);
  var t1 = karatsuba(c1, d1, power);
  var t2 = karatsuba(c0, d0, power);
  var t3 = karatsuba(add_int(c0, c1, power: power), add_int(d0, d1, power: power), power);
  var t4 = subtract_int(subtract_int(t3, t2, power: power), t1, power: power);
  //print("ans: $t2 $t4 $t1");

  for (int i = 0; i < c1.length; i++) {
    t4.add(0);
  }
  for (int i = 0; i < c1.length * 2; i++) {
    t2.add(0);
  }
  var ans = add_int(add_int(t1, t4, power: power), t2, power: power);
  return ans;
}

/*
 * limitations:
 * a little slow
 */
List long_div(List a, List b, [int power = 15]) {
  //a = lead0(a);
  //print('div a: $a');
  //print('div b: $b');
  if (a.length < b.length) return [[0], a];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [[0], a];
    else return [[1], subtract_int(a, b, power: power)];
  }
  if (a.length == b.length + 1) {
    var result = long_div_sub(a, b, power);
    //var remainder = long_div(result[1], [constant], power);
    if (result[0] == pow(10, 15)) return [[1, 0], 0];
    return [result[0], result[1]];
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
  //var remainder = long_div(div[1], [constant], power);
  var quotient = lead0(add_int(prime[0], div[0], power: power));
  //print('div: $div');
  return [quotient, div[1]];
}

List long_div_sub(List a, List b, [int power = 15]) {
  const BASE = 3;
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
  //if (q == pow(10, 15)) q = [1, 0];
  t = subtract_int(a, t, power: power);
  //print(q);
  //print('t: $t');
  return [[q], t];
}

/*
 * Burnikel-Ziegler division
 */
List two_by_one(List a, List b) {
  print('2_1');
  a = lead0(a);

  if (b.length == 1) {
    return long_div(a, b);
  }
  if (b.length.isOdd) {
    b.insert(0, 0);
  }

  var a_size = a.length;
  var size = b.length;
  var num_a = new List(4);
  var num_b = new List(2);

  for (var i = a_size; i < size * 2; i++) {
    a.insert(0, 0);
  }
  print('a: $a');
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
  var q1 = three_by_two(dividendq1, b);
  var dividendq2 = new List.from(q1[1])..addAll(num_a[0]);
  print('dividendq2: $dividendq2');
  var q2 = three_by_two(dividendq2, b);
  //print('q1: $q1');
  //print('q2: $q2');
  var quotient = new List.from(q1[0])..addAll(q2[0]);
  var remainder = q2[1];

  print('final 2_1: $quotient and remainder $remainder');
  quotient = lead0(quotient);
  return [quotient, remainder];
}

List three_by_two(List a, List b) { // bug with numbers that are too small and add extra 0s
  print('3_2');
  a = lead0(a);
  //var flag = false;
  //if (b.length.isOdd) {
  //  b.add(0);
  //  flag = true;
  //}
  


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
    var result = two_by_one(dividend2_1, num_b[1]);
    print('results: $result');
    q_hat = result[0];
    r_one = result[1];
  }
  else {
    q_hat = [1];
    for (var i = 0; i < size; i++) {
      q_hat.add(0);
    }
    q_hat = subtract_int(q_hat, [1]);
    r_one = subtract_int(num_a[2], num_b[1]);
    r_one.addAll(add_int(num_a[1], num_b[1]));
  }
  print('r_one: $r_one');
  var r_hat = new List.from(r_one)..addAll(num_a[0]);
  print('r_hat proto: $r_hat');
  r_hat = div_sub_helper(r_hat, multifull(q_hat, num_b[0]));
  print('r_hat final: $r_hat');

  if (r_hat[0] == -1) {
    r_hat.remove(-1);
    while (r_hat[0] != -1) {
      r_hat = div_sub_helper(r_hat, b);
      q_hat = subtract_int(q_hat, [1]);
    }
    r_hat.remove(-1);
  }
  print('final 3_2: $q_hat and remainder $r_hat');
  q_hat = lead0(q_hat);
  //if (flag && r_hat.length > 1) {
  //  print('-------------------');
  //  r_hat.removeAt(r_hat.length - 1);
  //}
  return [q_hat, r_hat];
}

List div_sub_helper(List a, List b, [int power = 15]) {
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
  ans = lead0(ans);
  b = lead0(b);
  if (carry == -1) {
    var carrybase = [1];
    for (var i = 0; i < ans.length; i++) {
      carrybase.add(0);
    }
    ans = subtract_int(carrybase, ans);
    ans.insert(0, -1);
  }
  return ans;
}
