import 'dart:math';

void main() {


  //var rect = two_by_one(43245600, 6400);
  //three_by_two(432, 6400);
  //print(rect);
  //three_by_two(562348, 6400);

  //jkl(-45645);
  var rect = barrett(5623486, 6465, 1);
  print (rect);
}

/*
subtract_second(List a, List b) {
  int q = 0;
  int r = 0;
  var c = new List();
  for (int i = 0; i < length; i++) {

  }
}
*/

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
