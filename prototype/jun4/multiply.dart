import 'dart:math';
import 'longnum.dart';

// anything smaller than 10 digits
long_multi(longnum a, longnum b) {
  var c = new longnum();

  for (int i  = 0; i < a.value.length; i++) {
    for (int j = 0; j < b.value.length; j++) {
      //print(a.value[a.value.length - 1 - i]);
      //print(b.value[b.value.length - 1 - j]);
      c.value[i + j] = c.value[i + j] + (a.value[a.value.length - i - 1] * b.value[b.value.length - j - 1]);
      if (c.value[i + j] >= 10) {
        var p = c.value[i + j] ~/ 10;
        i + j + 1 == c.value.length ? c.value.add(p) : c.value[i + j + 1] += p;
        c.value[i + j] -= p * 10;
      }
      else {
        c.value.add(0);
      }
      //print(c.value);
    }
  }

  c.value = (c.value.reversed).toList();
  var k = c.value.length;
  for (int j = 0; j < k; j++) {
    if (c.value[0] != 0) {
      break;
    }
    c.value.removeAt(0);
  }

  return c;
}

karatsuba(longnum a, longnum b) {
  const BASE = 10;
  const MUL = 3;
  const K = 2;

  //var size = (a.value.length > b.value.length) ? a.value.length : b.value.length;

  var num_a = [[], []], num_b = [[],[]];
  var num_c = new List(3);

  num_a[0] = (a.value.getRange(0, a.value.length ~/ 2)).toList();
  num_a[1] = (a.value.getRange(a.value.length ~/ 2, a.value.length)).toList();
  num_b[0] = (b.value.getRange(0, b.value.length ~/ 2)).toList();
  num_b[1] = (b.value.getRange(b.value.length ~/ 2, b.value.length)).toList();





  print(num_a);
  print(num_b);




  /*
  var num_a = [];
  var num_b = [];

  var num_c = new List(3);
  num_c[0] = num_a[0] * num_b[0];
  num_c[2] = num_a[1] * num_b[1];
  num_c[1] = (num_a[1] + num_a[0]) * (num_b[1] + num_b[0]) - num_c[0] - num_c[2];

  var ans = num_c[0] * pow(BASE, 2 * MUL) + num_c[1] * pow(BASE, MUL) + num_c[2];
  */

  //return ans;





}


// integer implementation
karatsuba_int(int a, int b) {
  const BASE = 10;
  //const MUL = 3;
  const K = 2;

  var MUL = max(((log(a) / log(BASE)) / K).floor(),
          ((log(b) / log(BASE)) / K).floor()) + 1;

  print(MUL);

  var num_a = [a ~/ pow(BASE, MUL), a % pow(BASE, MUL)];
  var num_b = [b ~/ pow(BASE, MUL), b % pow(BASE, MUL)];

  var num_c = new List(3);
  num_c[0] = num_a[0] * num_b[0];
  num_c[2] = num_a[1] * num_b[1];
  num_c[1] = (num_a[1] + num_a[0]) * (num_b[1] + num_b[0]) - num_c[0] - num_c[2];

  var ans = num_c[0] * pow(BASE, 2 * MUL) + num_c[1] * pow(BASE, MUL) + num_c[2];
  return ans;
}

// basic implementation
toomcook_basic(int a, int b) {
  var lista = [];
  var listb = [];
  var listc = new List(3);

  lista.add((a -  a % 10) / 10);
  lista.add(a % 10);
  listb.add((b -  b % 10) / 10);
  listb.add(b % 10);

  listc[2] = lista[1] * listb[1];
  var temp1 = (lista[0] + lista[1]) * (listb[0] + listb[1]) - listc[2];
  var temp2 = (lista[1] - lista[0]) * (listb[1] - listb[0]) - listc[2];

  listc[0] = (temp1 + temp2) / 2;
  listc[1] = temp1 - listc[0];

  var ans = listc[0] * 100 + listc[1] * 10 + listc[2];

  print(ans);
}


// to be fixed
// exception to be made when user inputs something smaller than 3-digits numbers
// BASE to be made modular as numbers grow big and small
// need to make a class that sufficiently holds large enough numbers
toomcook3(int a, int b) {
  const BASE = 10000;
  const K = 3;

  var i_val = max(((log(a) / log(BASE)) / K).floor(),
          ((log(b) / log(BASE)) / K).floor()) + 1;

  //var stringa = a.toString();
  //var stringb = b.toString();
  print(i_val);

  var listA = new List(3);
  var listB = new List(3);

  listA[0] = (a / pow(BASE, 2 * i_val)).floor();
  listA[1] =
      ((a - listA[0] * pow(BASE, 2 * i_val)) / pow(BASE, i_val)).floor();
  listA[2] = (a % (pow(BASE, i_val)));

  listB[0] = (b / pow(BASE, 2 * i_val)).floor();
  listB[1] =
      ((b - listB[0] * pow(BASE, 2 * i_val)) / pow(BASE, i_val)).floor();
  listB[2] = (b % (pow(BASE, i_val)));

  print(listA);
  print(listB);

  var listP = new List(5);
  var p = listA[0] + listA[2];
  listP[0] = listA[0]; // p0
  listP[1] = p + listA[1]; // p1
  listP[2] = p - listA[1]; // p-1
  listP[3] = 2 * (listP[2] + listA[2]) - listA[0]; // p-2
  listP[4] = listA[2]; // p infin

  var listQ = new List(5);
  var q = listB[0] + listB[2];
  listQ[0] = listB[0];
  listQ[1] = q + listB[1];
  listQ[2] = q - listB[1];
  listQ[3] = 2 * (listQ[2] + listB[2]) - listB[0];
  listQ[4] = listB[2];

  var listR = new List(5);
  for (int i = 0; i < 5; i++) {
    listR[i] = listP[i] * listQ[i];
  }

  var trueR = new List(5);
  var r1 = (listR[1] - listR[2]) / 2;
  var r2 = listR[2] - listR[0];
  var r3 = (listR[3] - listR[1]) / 3;
  trueR[0] = listR[0];
  trueR[1] = r1 - r3;
  trueR[2] = r2 + r1 - listR[4];
  trueR[3] = (r2 - r3) / 2 + 2 * listR[4];
  trueR[4] = listR[4];
  // 0, 1, -1, -2, infin

  var ans = trueR[0] +
      trueR[1] * pow(BASE, i_val) +
      trueR[2] * pow(BASE, 2 * i_val) +
      trueR[3] * pow(BASE, 3 * i_val) +
      trueR[4] * pow(BASE, 4 * i_val);

  print(trueR);
  print(ans);
}


void main() {
  var num1 = new longnum.string('15648654');
  var num2 = new longnum.string('457');
  //print((long_multi(num1, num2)).value);
  //print(karatsuba_int(15648654 , 457));
  karatsuba(num1, num2);

}
