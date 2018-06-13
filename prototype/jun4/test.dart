import 'dart:math';
import 'longnum.dart';

void main() {

    //var asdf = new longnum.string('18349276');
    var hjkl = new longnum.string("123456789123456789123456789123456789.123456789123456789");
    var qwer = new longnum.string('4503599627370496.4568423185674564512');


    //print(hjkl.value);
    print(hjkl.decimal);
    //print(qwer.value);
    print(qwer.decimal);

    var uiop = add_proper(hjkl, qwer);
    print('uiop val: ${uiop.value}');
    print('uiop decimal: ${uiop.decimal}');
    //print('uiop sign: ${uiop.neg}');
  }

two_by_one(num a, num b) {
    const BASE = 10;
    int n = b.toString().length;
    var num_a = new List(4);
    var num_b = new List(2);

    num_a[0] = a % pow(BASE, n / 2);
    num_a[1] = (a % pow(BASE, n) - num_a[0]) ~/ pow(BASE, n / 2);
    num_a[2] = (a % pow(BASE, n * 3 / 2) - num_a[1] * pow(BASE, n / 2) - num_a[0]) ~/ pow(BASE, n);
    num_a[3] = a ~/ pow(BASE, n * 3 / 2);

    num_b[0] = b % pow(BASE, n / 2);
    num_b[1] = b ~/ pow(BASE, n / 2);

    print(num_a[3] * pow(BASE, n) + num_a[2] * pow(BASE, n / 2) + num_a[1]);
    print(b);

    var result_1 = three_by_two(num_a[3] * pow(BASE, n) + num_a[2] * pow(BASE, n / 2) + num_a[1], b);
    var result_2 = three_by_two(result_1[1] * pow(BASE, n / 2) + num_a[0], b);

    var quotient = result_1[0] * pow(BASE, n / 2) + result_2[0];
    var remainder = result_2[1];

    return [quotient, remainder];
  }

List three_by_two(num a, num b) {
    const BASE = 10;
    int n = b.toString().length ~/ 2;
    var num_a = new List(3);
    var num_b = new List(2);

    num_a[0] = a % pow(BASE, n);
    num_a[1] = (a % pow(BASE, n * 2) - num_a[0]) ~/ pow(BASE, n);
    num_a[2] = a ~/ pow(BASE, n * 2);

    num_b[0] = b % pow(BASE, n);
    num_b[1] = b ~/ pow(BASE, n);

    var q_hat;
    var r_one;

    print(num_a[2]);
    print(num_b[1]);

    if (num_a[2] < num_b[1]) {
      var result = two_by_one(num_a[2] * pow(BASE, n) + num_a[1], num_b[1]);
      q_hat = result[0];
      r_one = result[1];
    }
    else {
      q_hat = pow(BASE, n) - 1;
      r_one = (num_a[2] - num_b[1]) * pow(BASE, n) + num_a[1] + num_b[1];
    }


    var r_hat = r_one * pow(BASE, n) + num_a[0] - q_hat * num_b[0];

    print("$q_hat $r_hat");
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

List barrett(int a, int b, int mu) {
     const BASE = 10;
     var a_size = a.toString().length;
     var b_size = b.toString().length;

     // check the sizes of the strings

     var a1 = (a * pow(BASE, -(b_size - 1))).floor();
     var q1 = (a1 * mu * pow(BASE, -(a_size - b_size + 1))).floor();
     var r1 = a - b * q1;
     int k = 1;
     bool test = false;
     var rk = r1;
     var qk = q1;
     while(!test) {

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
       k++;
     }



     return [qk, rk];
}

multi(num a, num, b) {

}

karatsuba_recursive(num a, num b) {
  var a_size = a.toString().length;
  var b_size = b.toString().length;
  var max_size = max(a_size, b_size);
  var min_size = min(a_size, b_size);

  //print(max_size);
  print('$a $b');

  if (max_size == 1) {
    return a * b;
  }

  int i = 0;
  for (i; i < 5; i++) {
    if (max_size <= pow(2, i)) {
      break;
    }
  }

  //var a_list = [int.parse(a.toString().substring(0, pow(2, i - 1))), int.parse(a.toString().substring(pow(2, i - 1), a.toString().length))];
  //var b_list = [int.parse(b.toString().substring(0, pow(2, i - 1))), int.parse(b.toString().substring(pow(2, i - 1), a.toString().length))];

  var a_list = [a ~/ pow(10, pow(2, i - 1)), a % pow(10, pow(2, i - 1))];
  var b_list = [b ~/ pow(10, pow(2, i - 1)), b % pow(10, pow(2, i - 1))];

  print(a_list);
  print(b_list);

  var t1 = karatsuba_recursive(a_list[1], b_list[1]);
  var t2 = karatsuba_recursive(a_list[0], b_list[0]);
  var t3 = karatsuba_recursive(a_list[0] + a_list[1], b_list[0] + b_list[1]);
  var t4 = t3 - t2 - t1;
  //print("ans: ${t1 + pow(10, pow(2, i - 1)) * t4 + t2}");
  return t1 + pow(10, pow(2, i - 1)) * t4 + t2 * pow(10, pow(2, i));
}


add_proper(longnum a, longnum b) {
  const BASE = 15;
  var shorter = min(a.value.length, b.value.length);
  var longer = max(a.value.length, b.value.length);
  var c = new longnum();
  var i;
  var r = longer == a.value.length ? a.value : b.value;

  for (i = 0; i < longer; i++) {
    if (i >= shorter) {
      c.value[i] += r[r.length - i - 1];
      if (c.value[i] >= pow(10, BASE)) { //c.value[i] >= pow(10, BASE)
        c.value.add(1);
        c.value[i] -= pow(10, BASE);
      }
      else {
        	c.value.add(0);
      }
    }
    else {
      //print(a.value[a.value.length - 1 - i]);
    	//print(b.value[b.value.length - 1 - i]);
    	c.value[i] += a.value[a.value.length - i - 1] + b.value[b.value.length - i - 1];
    	if (c.value[i] >= pow(10, BASE)) {
      	c.value.add(1);
      	c.value[i] -= pow(10, BASE);
    	}
    	else {
          c.value.add(0);
    	}
    }
    //print(c.value);
  }

  var longer_deci = max(a.decimal.length, b.decimal.length);
  var shorter_deci = min(a.decimal.length, b.decimal.length);
  var s = longer_deci == a.decimal.length ? a.decimal : b.decimal;

  for (i = 0; i < longer_deci; i++) {
    if (longer_deci - i > shorter_deci) {
      c.decimal[i] = s[s.length - i - 1];
      c.decimal.add(0);
    }
    else {
      print(a.decimal[s.length - i - 1]);
      print(b.decimal[s.length - i - 1]);
      print(c.decimal);
      c.decimal[i] += a.decimal[s.length - i - 1] + b.decimal[s.length - i - 1];
      if (c.decimal[i] >= pow(10, BASE)) {
        c.decimal.add(1);
        c.decimal[i] -= pow(10, BASE);
      }
      else {
        c.decimal.add(0);
      }
    }
    print(c.decimal);
  }



  c.value = (c.value.reversed).toList();
  c.decimal = (c.decimal.reversed).toList();
  var k = c.value.length;
  for (int j = 0; j < k; j++) {
    if (c.value[0] != 0) {
      break;
    }
    c.value.removeAt(0);
  }
  return c;

}
