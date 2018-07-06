import 'dart:math';

/*
 * removes leading and trailing zeros from a list
 */
List lead0(List number) {
  while (number.length != 1 && number.first == 0) number.removeAt(0);
  return number;
}

List trail0(List number) {
  while (number.length != 1 && number.last == 0) number.removeAt(number.length - 1);
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
  final size = max(a.length, b.length);
  var ans = [0];
  var c = size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;

  for (var i = 0; i < size - d_length; i++) d.insert(0, 0);
  for (var i = size - 1; i >= 0; i--) {
    ans[0] = (c[i] + d[i] + carry) % BASE;
    carry = ((c[i] + d[i] + carry) / BASE).floor();
    ans.insert(0, 0);
  }
  if (carry == 1) ans[0] = 1;
  ans = lead0(ans);
  d = lead0(d);
  return ans;
}

List add_deci(List a, List b) {
  final BASE = pow(10, 15);
  var ans = [0];
  final size = max(a.length, b.length);
  var c = size == a.length ? a : b;
  var d = c == a ? b : a;
  var d_length = d.length;
  var carry = 0;

  for (int i = 0; i < size - d_length; i++) d.add(0);
  for (int i = size - 1; i >= 0; i--) {
    ans[0] = (c[i] + d[i] + carry) % BASE;
    carry = ((c[i] + d[i] + carry) / BASE).floor();
    ans.insert(0, 0);
  }
  ans.removeAt(0);
  if (carry == 1) ans.insert(0, 1);
  d = trail0(d);
  return ans;
}

List subtract_int(List a, List b, {int carry = 0, int power = 15}) {
  final BASE = pow(10, power);
  final size = a.length;
  var ans = [0];
  var b_length = b.length;

  for (int i = 0; i < size - b_length; i++) b.insert(0, 0);
  for (int i = size - 1; i >= 0; i--) {
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
    ans.insert(0, 0);
  }
  ans = lead0(ans);
  b = lead0(b);
  return ans;
}

List subtract_deci(List a, List b) {
  final BASE = pow(10, 15);
  final size = max(a.length, b.length);
  var ans = [0];
  var carry = 0;

  if (a.length == size) for (var i = b.length; i < size; i++) b.add(0);
  else if (b.length == size) for (var i = a.length; i < size; i++) a.add(0);
  for (var i = size - 1; i >= 0; i--) {
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
    ans.insert(0, 0);
  }
  ans.removeAt(0);
  carry == -1 ? ans.insert(0, -1) : ans.insert(0, 0);
  a = trail0(a);
  b = trail0(b);
  return ans;
}

/*
 * long multiplication
 */
List multifull(List a, List b) {
  var ans = [0];
  var bk = a.length;
  var bm = b.length;
  var q = [0];
  for (int i  = 0; i < bk; i++) {
    for (int j = 0; j < bm; j++) {
      var t = add_int(add_int([ans[i + j]], q), multinum(a[bk - i - 1], b[bm - j - 1]));
      ans[i + j] = t.last;
      q = t.sublist(0, t.length - 1);
      if (q.isEmpty) q.add(0);
      ans.add(0);
    }
    ans[i + bm] = q.first;
    q = [0];
  }
  ans = ans.reversed.toList();
  ans = lead0(ans);
  return ans;
}

/*
 * multiplies two numbers and returns a list of the product.
 * if the product is too large to contain in a num class, divide and mutliply
 */
List multinum(num a, num b) {
  final BASE = pow(10, 7);
  final BASE_2 = pow(10, 14);
  if (a.toString().length + b.toString().length < 16) return [a * b];
  else {
    var alist = new List(3);
    var blist = new List(3);
    alist[2] = a % BASE;
    alist[1] = (a % BASE_2 - alist[2]) ~/ BASE;
    alist[0] = a ~/ BASE_2;
    blist[2] = b % BASE;
    blist[1] = (b % BASE_2 - blist[2]) ~/ BASE;
    blist[0] = b ~/ BASE_2;
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
}

/*
 * squaring two numbers yields slightly faster outputs than using the normal function
 */
List squaring(List number) {
  var ans = [0, 0];
  var q = [0];
  for (var i = 0; i < number.length - 1; i++) {
    for (var j = i + 1; j < number.length; j++) {
      var product = multinum(number[number.length - i - 1], number[number.length - j - 1]);
      product = multifull(product, [2]);
      var t = add_int(add_int([ans[i + j]], q), product);
      ans[i + j] = t.last;
      q = t.sublist(0, t.length - 1);
      if (q.isEmpty) q.add(0);
      ans.add(0);
    }
    ans[i + number.length] = q.first;
    q = [0];
  }
  ans = ans.reversed.toList();
  lead0(ans);
  for (var i = 0; i < number.length; i++) {
    var square = multinum(number[number.length - i - 1], number[number.length - i -1]);
    for (var j = 0; j < i * 2; j++) square.add(0);
    ans = add_int(ans, square);
  }
  return ans;
}

/*
 * Karatsuba algorithm for multiplying large numbers
 */
List karatsuba(List a, List b) {
  var max_size = max(a.length, b.length);
  int i = 0;
  if (max_size == 1) return multinum(a.first, b.first);
  var c = max_size == a.length ? a : b;
  var d = c == a ? b : a;
  final d_length = d.length;
  for (var i = 0; i < max_size - d_length; i++) d.insert(0, 0);
  while (max_size > pow(2, i)) i++;
  int power_2 = pow(2, i - 1).toInt();
  var c0 = c.sublist(0, power_2);
  var c1 = c.sublist(power_2, a.length);
  var d0 = d.sublist(0, power_2);
  var d1 = d.sublist(power_2, b.length);
  var t1 = karatsuba(c1, d1);
  var t2 = karatsuba(c0, d0);
  var t3 = karatsuba(add_int(c0, c1), add_int(d0, d1));
  var t4 = subtract_int(subtract_int(t3, t2), t1);
  for (int i = 0; i < c1.length; i++) t4.add(0);
  for (int i = 0; i < c1.length * 2; i++) t2.add(0);
  return add_int(add_int(t1, t4), t2);
}

/*
 * Karatsuba algorithm for squaring (slightly faster than normal)
 */
List karatsubasquare(List number) {
  final size = number.length;
  int i = 0;
  if (size == 1) return multinum(number.first, number.first);
  while (size > pow(2, i)) i++;
  int power_2 = pow(2, i - 1).toInt();
  var upper = number.sublist(0, power_2);
  var lower = number.sublist(power_2, number.length);
  var t1 = karatsubasquare(lower);
  var t2 = karatsubasquare(upper);
  var t3 = karatsubasquare(add_int(upper, lower));
  var t4 = subtract_int(subtract_int(t3, t2), t1);
  for (int i = 0; i < lower.length; i++) t4.add(0);
  for (int i = 0; i < lower.length * 2; i++) t2.add(0);
  return add_int(add_int(t1, t4), t2);
}

/*
 * long division
 */
List long_div(List a, List b) {
  if (a.length < b.length) return [[0], a];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [[0], a];
    else return [[1], subtract_int(a, b)];
  }
  if (a.length == b.length + 1) {
    var result = long_div_sub(a, b);
    if (result[0] == pow(10, 15)) return [[1, 0], 0];
    return [result[0], result[1]];
  }
  var bm = a.length - b.length - 1;
  var a_prime = a.sublist(0, a.length - bm);
  var s = a.sublist(a.length - bm, a.length);
  var prime = long_div_sub(a_prime, b);

  for (var i = 0; i < bm; i++) prime[1].add(0);
  var div = long_div(add_int(prime[1], s), b);
  for (var i = 0; i < bm; i++) prime[0].add(0);
  var quotient = lead0(add_int(prime[0], div[0]));
  return [quotient, div[1]];
}

/*
 * long division subroutine
 */
List long_div_sub(List a, List b) {
  if (a[0] > b[0]) {
    a = subtract_int(a, multifull(b, [1, 0]));
    var ans = long_div_sub(a, b);
    ans[0].insert(0, 1);
    return [ans[0], ans[1]];
  }
  var quotient = [((a[0] / b[0]) * pow(10, 15)).ceil()];
  quotient = add_int(quotient, [5]);
  var t = karatsuba(quotient, b);
  while (compare_list(t, a) == 1) {
    quotient = subtract_int(quotient, [1]);
    t = subtract_int(t, b);
  }
  t = subtract_int(a, t);
  return [quotient, t];
}

/*
 * Burnikel-Ziegler division for large numbers
 */
List two_by_one(List a, List b) {
  a = lead0(a);
  if (a.length < b.length) return [[0], a];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [[0], a];
    else return [[1], subtract_int(a, b)];
  }
  if (a.length == b.length + 1) {
    var result = long_div_sub(a, b);
    if (result[0] == pow(10, 15)) return [[1, 0], 0];
    return [result[0], result[1]];
  }
  if (b.length == 1) return long_div(a, b);
  if (b.length.isOdd) b.insert(0, 0);
  var a_size = a.length;
  var size = b.length;
  var num_a = new List(4);
  var num_b = new List(2);

  for (var i = a_size; i < size * 2; i++) a.insert(0, 0);
  num_b[0] = b.sublist(size ~/ 2, size);
  num_b[1] = b.sublist(0, size ~/ 2);

  num_a[3] = a.sublist(0, size ~/ 2);
  num_a[2] = a.sublist(size ~/ 2, size);
  num_a[1] = a.sublist(size, size ~/ 2 * 3);
  num_a[0] = a.sublist(size ~/ 2 * 3, a.length);
  var dividendq1 = new List.from(num_a[3])..addAll(num_a[2])..addAll(num_a[1]);
  var q1 = three_by_two(dividendq1, b);
  var dividendq2 = new List.from(q1[1])..addAll(num_a[0]);
  var q2 = three_by_two(dividendq2, b);
  var quotient = new List.from(q1[0])..addAll(q2[0]);
  var remainder = q2[1];
  quotient = lead0(quotient);
  return [quotient, remainder];
}

List three_by_two(List a, List b) { // bug with numbers that are too small and add extra 0s
  a = lead0(a);
  var flag = false;
  if (b[0] == 0) {
    b.removeAt(0);
    b.add(0);
    a.add(0);
    flag = true;
  }
  var a_size = a.length;
  var size = b.length ~/ 2;
  var num_a = new List(3);
  var num_b = new List(2);
  for (var i = a_size; i < size * 3; i++) a.insert(0, 0);
  num_a[2] = a.sublist(0, size);
  num_a[1] = a.sublist(size, size * 2);
  num_a[0] = a.sublist(size * 2, size * 3);

  num_b[0] = b.sublist(size, size * 2);
  num_b[1] = b.sublist(0, size);
  var q_hat, r_one;
  if (compare_list(num_a[2], num_b[1]) == 0) {
    var dividend2_1 = new List.from(num_a[2])..addAll(num_a[1]);
    var result = two_by_one(dividend2_1, num_b[1]);
    q_hat = result[0];
    r_one = result[1];
  }
  else {
    q_hat = [1];
    for (var i = 0; i < size; i++) q_hat.add(0);
    q_hat = subtract_int(q_hat, [1]);
    r_one = subtract_int(num_a[2], num_b[1]);
    r_one.addAll(add_int(num_a[1], num_b[1]));
  }
  var r_hat = new List.from(r_one)..addAll(num_a[0]);
  r_hat = div_sub_helper(r_hat, multifull(q_hat, num_b[0]));
  if (r_hat[0] == -1) {
    r_hat.remove(-1);
    while (r_hat[0] != -1) {
      r_hat = div_sub_helper(r_hat, b);
      q_hat = subtract_int(q_hat, [1]);
    }
    r_hat.remove(-1);
  }
  q_hat = lead0(q_hat);
  if (flag) {
    r_hat.removeAt(r_hat.length - 1);
    b.removeAt(b.length - 1);
    b.insert(0, 0);
  }
  return [q_hat, r_hat];
}

/*
 * division helper function to do subtraction with negative numbers
 */
List div_sub_helper(List a, List b) {
  final BASE = pow(10, 15);
  final size = max(a.length, b.length);
  final a_len = a.length;
  final b_len = b.length;
  var ans = [0];
  var carry = 0;

  if (a_len == size) for (var i = b_len; i < size; i++) b.insert(0, 0);
  else if (b_len == size) for (var i = a_len; i < size; i++) a.insert(0, 0);
  for (int i = size - 1; i >= 0; i--) {
    ans[0] = (a[i] - b[i] + carry) % BASE;
    carry = ((a[i] - b[i] + carry) / BASE).floor();
    ans.insert(0, 0);
  }
  ans = lead0(ans);
  b = lead0(b);
  if (carry == -1) {
    var carrybase = [1];
    for (var i = 0; i < ans.length; i++) carrybase.add(0);
    ans = subtract_int(carrybase, ans);
    ans.insert(0, -1);
  }
  return ans;
}
