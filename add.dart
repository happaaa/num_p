import 'dart:math';
import 'num_p.dart';
import 'format.dart';

// works with decimals and new num_p class properly
// intending to make it simpler in the near future
add(num_p a, num_p b) {
  const BASE = 15;
  var shorter = min(a.value.length, b.value.length);
  var longer = max(a.value.length, b.value.length);
  var longer_deci = max(a.decimal.length, b.decimal.length);
  var shorter_deci = min(a.decimal.length, b.decimal.length);
  var c = new num_p();
  var i;
  var q = longer == a.value.length ? a.value : b.value;
  var r, s;

  // probably a much better way to do this
  if (longer_deci == a.decimal.length && longer_deci > shorter_deci) {
    r = a.decimal;
    s = b.decimal;
  }
  else if (longer_deci == b.decimal.length && longer_deci > shorter_deci) {
    r = b.decimal;
    s = a.decimal;
  }
  else {
    if (a.decimal[a.decimal.length - 1].toString().length > b.decimal[b.decimal.length - 1].toString().length) {
      r = a.decimal;
      s = b.decimal;
    }
    else {
      r = b.decimal;
      s = a.decimal;
    }
    //print(r[r.length - 1].toString().length);
    //print(s[s.length - 1].toString().length);
  }

  // decimal
  for (i = 0; i < longer_deci; i++) {
    var place = r.length - i - 1;
    var r_place_size = r[place].toString().length;
    if (longer_deci - i > shorter_deci) {
      c.decimal[i] = r[place];
      c.decimal.add(0);
    }
    else {

      if (s[place].toString().length < r_place_size) {
        s[place] *= pow(10, r_place_size - s[place].toString().length);
      }

      c.decimal[i] += r[place] + s[place];
      if (c.decimal[i] >= pow(10, r_place_size)) {
        c.decimal.add(1);
        c.decimal[i] -= pow(10, r_place_size);
      }
      else {
        c.decimal.add(0);
      }
    }
    print(c.decimal);
  }

  // carry over from decimal to value
  if (c.decimal[c.decimal.length - 1] == 1) {
    c.value[0] = 1;
    c.decimal[c.decimal.length - 1] = 0;
  }

  // value
  for (i = 0; i < longer; i++) {
    if (i >= shorter) {
      c.value[i] += q[q.length - i - 1];
      if (c.value[i] >= pow(10, BASE)) { //not sure if this is the best way about this
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


  // formatting
  c = leadingzeros(c);

  return c;
}
