import 'dart:math';
import 'lib/src/num_p.dart';

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


// works with decimals and new num_p class properly
add_proper(num_p a, num_p b) {
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
  // eventually use leadingzeros.dart instead
  c.value = (c.value.reversed).toList();
  c.decimal = (c.decimal.reversed).toList();
  var k = c.value.length, l = c.decimal.length;
  for (var u = 0; u < k && c.value[0] == 0; u++) {
    c.value.removeAt(0);
  }
  for (var v = 0; v < l && c.decimal[0] == 0; v++) {
    c.decimal.removeAt(0);
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

subtract_proper(num_p a, num_p b) {

}





void main() {
  //var asdf = new num_p.string('18349276');
  var hjkl = new num_p.string("123456789123456789123456789123456789.423456789123456789");
  var qwer = new num_p.string('4503599627370496.6568423185674564512');


  //print(hjkl.value);
  print(hjkl.decimal);
  //print(qwer.value);
  print(qwer.decimal);

  var uiop = add_proper(hjkl, qwer);
  print('uiop val: ${uiop.value}');
  print('uiop decimal: ${uiop.decimal}');
  //print('uiop sign: ${uiop.neg}');;


}
