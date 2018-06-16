import "dart:math";

class num_p {
 	var number = new List();


  num_p(String string) {
    for (int i = 0; i < string.length; i++) {
      number.add(int.parse(string[i]));
    }
  }

  get_number() {
    return number;
  }

  set_number(String string) {
    number.clear();
    for (int i = 0; i < string.length; i++) {
      number.add(int.parse(string[i]));
    }
  }
}

void main() {


 	multiply_full(1234567890123456789012, 987654321987654321098);

  print(E);

  var really = new num_p("1234");
  print(really.get_number());

  /*var letters = "123456789";
  var lists = new List();
  for (int i = 0; i < letters.length; i++) {
    lists[i] = int.parse(letters[i]);
    print(letters[i]);
  }
  print(lists);
  */

  print(pow(2, 53) - pow(2, 52));
  print(pow(2, 52));

  print(123456789-154856956);
  print(subtract_full(123456789, 154856956));
  print(add_full(4586, 5414));

}

toomcook_basic(int a, int b) {
  var lista = [];
  var listb = [];
  var listc = new List(3);
  // var stringa = a.toString();
  // var stringb = b.toString();

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
// try/catch blocks inside if user tries anything funny
// exception when user inputs a single digit number
// make it work for doubles
// doesn't work on zeros
add_full(var a, var b) {
  var stringa = a.toString();
  var stringb = b.toString();
  var num_a = new List(2);
  var num_b = new List(2);
  var num_c = new List(2);


  var length = min(stringa.length, stringb.length);
  var half_length = (length / 2).ceil();

  num_a[0] = int.parse(stringa.substring(0, stringa.length - half_length));
  num_a[1] = int.parse(stringa.substring(stringa.length - half_length, stringa.length));

  num_b[0] = int.parse(stringb.substring(0, stringb.length - half_length));
  num_b[1] = int.parse(stringb.substring(stringb.length - half_length, stringb.length));


  num_c[1] = num_a[1] + num_b[1];
  num_c[0] = num_a[0] + num_b[0];

  print(half_length);
  print(num_c);

  if (num_c[1].toString().startsWith('1')) {
    num_c[1] -= pow(10, half_length);//int.parse((num_c[1].toString()).substring(1, (num_c[1].toString()).length));
    num_c[0]++;
  }

  print(num_c);

  var ans = int.parse(num_c[0].toString() + num_c[1].toString());

  return ans;
}


subtract_full(var a, var b) {
  var stringa = a.toString();
  var stringb = b.toString();
  var num_a = new List(2);
  var num_b = new List(2);
  var num_c = new List(2);


  var length = min(stringa.length, stringb.length);
  var half_length = (length / 2).ceil();

  num_a[0] = int.parse(stringa.substring(0, stringa.length - half_length));
  num_a[1] = int.parse(stringa.substring(stringa.length - half_length, stringa.length));

  num_b[0] = int.parse(stringb.substring(0, stringb.length - half_length));
  num_b[1] = int.parse(stringb.substring(stringb.length - half_length, stringb.length));


  num_c[1] = num_a[1] - num_b[1];
  num_c[0] = num_a[0] - num_b[0];

  print(num_a);
  print(num_b);
  print(half_length);
  print(num_c);

  if (num_c[1].isNegative) {
    num_c[1] += pow(10, half_length); //(num_c[1].toString()).substring(1, (num_c[1].toString()).length);
    num_c[0]--;
  }

  print(num_c);

  var ans = int.parse(num_c[0].toString() + num_c[1].toString());

  return ans;
}

// to be fixed
// exception to be made when user inputs something smaller than 3-digits numbers
// BASE to be made modular as numbers grow big and small
// need to make a class that sufficiently holds large enough numbers
multiply_full(int a, int b) {
  const BASE = 10000;
  const K = 3;

  var i_val = max(((log(a) / log(BASE)) / K).floor(),
          ((log(b) / log(BASE)) / K).floor()) +
      1;

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

haha (String a) {
  print(a);
}







// 456 -> [4, 5, 6]
