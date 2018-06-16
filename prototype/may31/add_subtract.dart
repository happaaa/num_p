import 'dart:math';
import 'num_p.dart';

// to be fixed:
// work for doubles
// work for negative numbers
// very messy
// overload '+' operator
add(num_p a, num_p b) {
  var shorter = min(a.value.length, b.value.length);
  var longer = max(a.value.length, b.value.length);
  var c = new num_p();
  int i;
  var r = longer == a.value.length ? a.value : b.value;

  for (i = 0; i < longer; i++) {
    if (i >= shorter) {
      c.value[i] += r[r.length - i - 1];
      if (c.value[i] >= 10) {
        c.value.add(1);
        c.value[i] -= 10;
      }
      else {
        	c.value.add(0);
      }
    }
    else {
      //print(a.value[a.value.length - 1 - i]);
    	//print(b.value[b.value.length - 1 - i]);
    	c.value[i] += a.value[a.value.length - i - 1] + b.value[b.value.length - i - 1];
    	if (c.value[i] >= 10) {
      	c.value.add(1);
      	c.value[i] -= 10;
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
      //print(a.decimal[s.length - i - 1]);
      //print(b.decimal[s.length - i - 1]);
      //print(c.decimal);
      c.decimal[i] += a.decimal[s.length - i - 1] + b.decimal[s.length - i - 1];
      if (c.decimal[i] >= 10) {
        c.decimal.add(1);
        c.decimal[i] -= 10;
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



// to be fixed:
// work with decimals
// work with negative numbers
// very messy
// need better variable names
subtract(num_p a, num_p b) {
  var shorter = min(a.value.length, b.value.length);
  var longer = max(a.value.length, b.value.length);
  var c = new num_p();

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
    for (int i = 0; i < longer; i++) {
      if (a.value[i] > b.value[i]) {
        r = a.value;
        c.neg = false;
        break;
      }
      else if (a.value[i] < b.value[i]) {
        r = b.value;
        c.neg = true;
        break;
      }
    }
  }

  for (i = 0; i < longer; i++) {
    if (i >= shorter) {
      //print(r[r.length - i - 1]);
      c.value[i] += r[r.length - i - 1];
      //print(c.value);
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
      //print(a.value[a.value.length - i - 1]);
      //print(b.value[b.value.length - i - 1]);
      c.neg ? c.value[i] += b.value[b.value.length - i - 1] - a.value[a.value.length - i - 1]
            : c.value[i] += a.value[a.value.length - i - 1] - b.value[b.value.length - i - 1];

      if (c.value[i] < 0) {
        c.value.add(-1);
        c.value[i] += 10;
      }
      else {
          c.value.add(0);
      }
    }
    //print(c.value);
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



void main() {
  var num1 = new num_p.string('54.5647');
  var num2 = new num_p.string('128.128');
  //print(num1.value);
  //print(realnum.decimal);
  //print(realnum.neg);
  //print(num2.value);

  var c = add(num1, num2);
  print(c.value);
  print(c.decimal);
  //var d = subtract(num1, num2);
  //print(d.value);
  //print(d.neg);




}
