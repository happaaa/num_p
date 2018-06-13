import 'dart:math';


List two_by_one(num a, num b) {
  const BASE = 10;
  int n = b.toString().length;
  print('2_1');

  if (n == 1) {
    return [a ~/ b, a % b];
  }

  var num_a = new List(4);
  var num_b = new List(2);
  num_a[0] = a % pow(BASE, n ~/ 2);
  num_a[1] = (a % pow(BASE, n) - num_a[0]) ~/ pow(BASE, n / 2);
  num_a[2] = (a % pow(BASE, n * 3 / 2) - num_a[1] * pow(BASE, n / 2) - num_a[0]) ~/ pow(BASE, n);
  num_a[3] = a ~/ pow(BASE, n * 3 / 2);
  num_b[0] = b % pow(BASE, n ~/ 2);
  num_b[1] = b ~/ pow(BASE, n / 2);
  //print('a: $num_a');
  //print('b: $num_b');
  //print('3_2 input: ${num_a[3] * pow(BASE, n) + num_a[2] * pow(BASE, n ~/ 2) + num_a[1]} and $b');
  var q1 = three_by_two(num_a[3] * pow(BASE, n) + num_a[2] * pow(BASE, n ~/ 2) + num_a[1], b);
  var q2 = three_by_two(q1[1] * pow(BASE, n ~/ 2) + num_a[0], b);
  //print('q1: $q1');
  //print('q2: $q2');
  var quotient = q1[0] * pow(BASE, n ~/ 2) + q2[0];
  var remainder = q2[1];
  return [quotient, remainder];
}

List three_by_two(num a, num b) {
  const BASE = 10;
  int n = b.toString().length ~/ 2;
  var num_a = new List(3);
  var num_b = new List(2);
  print('3_2');

  num_a[0] = a % pow(BASE, n);
  num_a[1] = (a % pow(BASE, n * 2) - num_a[0]) ~/ pow(BASE, n);
  num_a[2] = a ~/ pow(BASE, n * 2);
  num_b[0] = b % pow(BASE, n);
  num_b[1] = b ~/ pow(BASE, n);

  var q_hat;
  var r_one;
  if (num_a[2] < num_b[1]) {
    //print('2_1 input: ${num_a[2] * pow(BASE, n) + num_a[1]} and ${num_b[1]}');
    var result = two_by_one(num_a[2] * pow(BASE, n) + num_a[1], num_b[1]);
    //print('result from 2_1: $result');
    q_hat = result[0];
    r_one = result[1];
  }
  else {
    q_hat = pow(BASE, n) - 1;
    r_one = (num_a[2] - num_b[1]) * pow(BASE, n) + num_a[1] + num_b[1];
  }

  var r_hat = r_one * pow(BASE, n) + num_a[0] - q_hat * num_b[0];
  //print("q and r: $q_hat $r_hat");
  if (r_hat < 0) {
    r_hat = r_hat + b;
    q_hat = q_hat - 1;
  }
  if (r_hat < 0) {
    r_hat = r_hat + b;
    q_hat = q_hat - 1;
  }
  return [q_hat, r_hat];
}

List barrett(int a, int b, int mu) { // mu ~~ pow(BASE, a_size) / b
  const BASE = 10;
  var a_size = a.toString().length;
  var b_size = b.toString().length;

  // check the sizes of the strings

  var a1 = (a * pow(BASE, -(b_size - 1))).floor();
  var q1 = (a1 * mu * pow(BASE, -(a_size - b_size + 1))).floor();
  var r1 = a - b * q1;
  bool test = false;
  var rk = r1;
  var qk = q1;
  //print('q1: $q1');
  while(!test) {
    //print('qk: $qk');
    //print('rk: $rk');
    if (rk >= 0 && rk < b) {
      test = true;
    }
    else if (rk < 0) {
      rk += b;
      qk -= 1;
    }
    else {
      rk -= b;
      qk += 1;
    }
  }
  return [qk, rk];
}


newton(var v, var n) {
  var v_num = v.toString();
  var zk = (32 / (4 * int.parse(v_num[2]) + 2 * int.parse(v_num[3]) + int.parse(v_num[4]))).floor();
  zk /= 4;
  var sk, tk, uk, wk;
  for (var i = 0; i < n; i++) {
    sk = pow(zk, 2);
    print('sk: $sk');
    tk = v - (v % pow(10, - (pow(2, i + 1) + 3)));
    print('tk fake: ${(v % pow(10, - (pow(2, i + 1) + 3)))}');
    print('tk: $tk');
    uk = tk * sk;
    uk = uk - (uk % pow(10, - (pow(2, i + 1) + 1)));
    print('uk: $uk');
    wk = 2 * zk;
    print('wk: $wk');
    zk = wk - uk;
    print('zk: $zk');
  }
  print(zk);
}


long_div(num a, num b) {
  final BASE = 10;
  var a_size = a.toString().length;
  var b_size = b.toString().length;
  print('a: $a');
  print('b: $b');

  if (a_size < b_size) {
    return [0, a];
  }

  if (a_size == b_size) {
    return a < b ? [0, a] : [1, a - b];
  }

  if (a_size == b_size + 1) {
    return long_div_sub(a, b);
  }
  var power = a_size - b_size - 1;
  var a_prime = (a / pow(BASE, power)).floor();
  var s = a % pow(BASE, power);
  var q_prime = long_div_sub(a_prime, b);
  var q = long_div(pow(BASE, power) * q_prime[1] + s, b);
  return [q_prime[0] * pow(BASE, power) + q[0], q[1]];
}


long_div_sub(num a, num b) {
  final BASE = 10;
  print('div a: $a');
  print('b: $b');
  if (a >= b * 10) {
    var ans = long_div_sub(a - b * BASE, b);
    return [ans[0] + BASE, ans[1]];
  }

  var a_msb = int.parse(a.toString()[0]) * BASE + int.parse(a.toString()[1]);

  var q = (a_msb) ~/ int.parse(b.toString()[0]);
  var t = q * b;
  if (t > a) {
    q -= 1;
    t -= b;
  }
  if (t > a) {
    q -= 1;
    t -= b;
  }
  return [q, a - t];
}


newton_better(num v, num n) {
  //var v_num = v.toString();
  var i = 1;
  var zk = (1 / v)  - ((1 / v) % pow(10 , -i));
  print('start zk: $zk');
  var sk, tk, uk, wk;
  for (i; i < n; i++) {
    sk = pow(zk, 2);
    print('sk $i: $sk');
    tk = v - (v % pow(10, - (2 * i + 3)));
    //print('tk fake: ${(v % pow(10, - (pow(2, i + 1) + 3)))}');
    print('tk: $tk');
    uk = tk * sk;
    uk = uk - (uk % pow(10, - (2 * i + 1)));
    print('uk: $uk');
    wk = 2 * zk;
    print('wk: $wk');
    zk = wk - uk;
    print('zk: $zk');
  }
  print(zk);
}
