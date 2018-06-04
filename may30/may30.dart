import 'dart:math';

class num_p {
  //static final E = [2, '.', 7, 1, 8, 2, 8, 1, 8, 2, 8, 4, 5, 9, 0 ,4, 5, 2, 3, 5, 3, 6, 0, 2, 8, 7, 4, 7,
  //                      1, 3, 5, 2, 6, 6, 2, 4, 9, 7, 7, 5, 7, 2, 4, 7, 0, 9, 3, 6, 9, 9, 9, 5, 9, 5, 7, 4, 9, 6, 6];
  static final E_string = "2.718281828459045235360287471352662497757247093699959574966";
  static final PI_string = "3.141592653589793238462643383279502884197169399375105820974";
  static final LN2_string = "0.693147180559945309417232121458176568075500134360255254120";
  static final LN10_string = "2.302585092994045684017991454684364207601101488628772976033";
  static final LOG2E_string = "1.442695040888963407359924681001892137426645954152985934135";
  static final LOG10E_string = "0.434294481903251827651128918916605082294397005803666566114";
  static final SQRT1_2_string = "0.707106781186547524400844362104849039284835937688474036588";
  static final SQRT2_string = "1.414213562373095048801688724209698078569671875376948073176";

  // either have two lists, one before decimal and one after
  // 		or make it a string and parse it every time i do an operation
  // also wondering it having more than 1 digit per position is worth it
 	var value = new List();
  var decimal = new List();
  bool neg = false;

  // default constructor (don't really need this)
  num_p() {
    value = [];
    decimal = [];
    neg = false;
  }

  // constructor from string
  num_p.string(String string) {
    int i = 0;
    if (string.startsWith('-')) {
      neg = true;
      i = 1;
    }
    bool dec = false;
    for (i; i < string.length; i++) {
      if (string[i] == '.') {
        dec = true;
        continue;
      }
      if (dec) {
        decimal.add(int.parse(string[i]));
      }
      else {
      	value.add(int.parse(string[i]));
      }
    }
  }

  // not sure how to implement with negation and decimals
  // constructor from list
  /*num_p.list(List list) {
    for (int i = 0; i < list.length; i++) {
      value.add(list[i]);
    }
  }*/

  // constructor from num
  num_p.number(num number) {
 		if (number.isNegative) {
      neg = true;
      number = number.abs();
    }
    bool dec = false;
    var num_string = number.toString();
    for (int i = 0; i < num_string.length; i++) {
      if (num_string[i] == '.') {
        dec = true;
        continue;
      }
      if (dec) {
        decimal.add(int.parse(num_string[i]));
      }
      else {
        value.add(int.parse(num_string[i]));
      }

    }
  }

  // setter using a string
  set string(String string) {
    value.clear();
    int i = 0;
    if (string.startsWith('-')) {
      neg = true;
      i = 1;
    }
    bool dec = false;
    for (i; i < string.length; i++) {
      if (string[i] == '.') {
        dec = true;
        continue;
      }
      if (dec) {
        decimal.add(int.parse(string[i]));
      }
      else {
      	value.add(int.parse(string[i]));
      }
    }
  }





}

// to be fixed:
// work for doubles
// work for negative numbers
// very messy
// overload '+' operator
add(num_p a, num_p b) {
  var shorter = min(a.value.length, b.value.length);
  var longer = max(a.value.length, b.value.length);
  var c = new num_p();

  c.value.add(0);
  int i;
  var r;
  if (longer == a.value.length) {
    r = a.value;
  }
  else {
    r = b.value;
  }

  for (i = 0; i < longer; i++) {
    //c.value.add(0);
    if (i >= shorter) {
      c.value[i] += r[r.length - 1 - i];
      if (c.value[i] >= 10) {
        c.value.add(1);
        c.value[i] -= 10;
      }
      else {
       	if (i != longer - 1) {
        	c.value.add(0);
        }
      }
    }
    else {
      //print(a.value[a.value.length - 1 - i]);
    	//print(b.value[b.value.length - 1 - i]);
    	c.value[i] += a.value[a.value.length - 1 - i] + b.value[b.value.length - 1 - i];
    	if (c.value[i] >= 10) {
      	c.value.add(1);
      	c.value[i] -= 10;
    	}
    	else {
        if (i != longer - 1) {
          c.value.add(0);
        }
    	}
    }
    //print(c.value);
  }
  c.value = (c.value.reversed).toList();
  return c;
}

// to be fixed:
// work with decimals
// work with negative numbers
// very messy
subtract(num_p a, num_p b) {
  var shorter = min(a.value.length, b.value.length);
  var longer = max(a.value.length, b.value.length);
  var c = new num_p();

  c.value.add(0);
  int i;
  var r;


  if (longer == a.value.length && longer > shorter) {
    r = a.value;
    c.neg = false;
  }
  else if (longer == b.value.length && longer > shorter) {
    r = b.value;
    c.neg = true;
  }
  else {


  }


  for (i = 0; i < longer; i++) {
    //c.value.add(0);
    if (i >= shorter) {
      c.value[i] -= r[r.length - 1 - i];
      print(c.value);
      if (c.value[i] < 0) {
        c.value.add(-1);
        c.value[i] += 10;
      }
      else {
        //if (i != longer - 1) {
          c.value.add(0);
        //}
      }
    }
    else {
      //print(a.value[a.value.length - 1 - i]);
      //print(b.value[b.value.length - 1 - i]);
      if (c.neg) {
        c.value[i] += b.value[b.value.length - i - 1] - a.value[a.value.length - i - 1];
      }
      else {
        c.value[i] += a.value[a.value.length - i - 1] - b.value[b.value.length - i - 1];
      }
      if (c.value[i] < 0) {
        c.value.add(-1);
        c.value[i] += 10;
      }
      else {
        //if (i != longer - 1) {
          c.value.add(0);
        //}
      }
    }
    print(c.value);
  }

  c.value = (c.value.reversed).toList();
  var k = c.value.length;
  for (int j = 0; j < k; j++) {
    if (c.value[0] != 0) {
      break;
    }
    c.value.removeAt(0);
  }

  print(c.value);
  print(c.neg);



}

multiply(num_p a, num_p b) {

}

divide(num_p a, num_p b) {

}

void main() {
  print(E);

  /*var nu_E = new List();
  var string_E = E.toString();

  print(string_E.length);

  var really = new num_p('1234');
  print(num_p.E.length);*/

  var realnum = new num_p.string('1004');
  var fakenum = new num_p.string('12');
  print(realnum.value);
  //print(realnum.decimal);
  //print(realnum.neg);
  print(fakenum.value);

  var c = add(realnum, fakenum);
  print(c.value);
  subtract(realnum, fakenum);

  var t = [1, 2, 3, 4];
  var q = t.reversed;
  q = q.toList();
  //print(q);




}
