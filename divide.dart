import 'dart:math';

long_division(int numer, int denom) {

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
     //int k = 1;
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
       //k++;
     }



     return [qk, rk];
}
