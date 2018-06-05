import 'dart:math';
import 'num_p.dart';
import 'format.dart';

subtract_stupid(num_p a, num_p b) {
  const BASE = 10;
  const POWER = 15;
  var c = new num_p(); // new num_p
  var bk = max(a.value.length, b.value.length); // base power
  var qk = max(a.decimal.length, b.decimal.length);
  var q, w, e, r; // values

  if (a.value.length > b.value.length) {
    q = a.value;
    w = b.value;
    e = a.decimal;
    r = b.decimal;
  }
  else if (a.value.length < b.value.length) {
    q = b.value;
    w = a.value;
    e = b.decimal;
    r = a.decimal;
    c.neg = true;
  }
  else {
    for (int i = 0; i < a.value.length; i++) {
      if (a.value[i] > b.value[i]) {
        q = a.value;
        w = b.value;
        e = a.decimal;
        r = b.decimal;
        break;
      }
      else if (b.value[i] > a.value[i]) {
        q = b.value;
        w = a.value;
        e = b.decimal;
        r = a.decimal;
        c.neg = true;
        break;
      }
      else if (i == a.value.length - 1) {
        q = a.value;
        w = b.value;
        e = a.decimal;
        r = b.decimal;
      }
    }
  }

  if (e.length == qk) {
    for (int i = 0; i < qk - r.length; i++) {
      r.add(0);
    }
  }
  else if (r.length == qk) {
    for (int i = 0; i < qk - e.length; i++) {
      e.add(0);
    }
  }

  int carry = 0;
  var place;
  for (int i = 0; i < qk; i++) {
    place = e.length - i - 1;
    e[place] *= pow(BASE, POWER - e[place].toString().length);
    r[place] *= pow(BASE, POWER - r[place].toString().length);
    c.decimal[i] = (e[place] - r[place] + carry) % pow(BASE, POWER);
    carry = ((e[place] - r[place] + carry) / pow(BASE, POWER)).floor();
    c.decimal.add(0);
  }

  for (int i = 0; i < bk - w.length; i++) {
    w.insert(0, 0);
  }

  for (int i = 0; i < bk; i++) {
    place = q.length - i - 1;
    c.value[i] = (q[place] - w[place] + carry) % pow(BASE, POWER);
    carry = ((q[place] - w[place] + carry) / pow(BASE, POWER)).floor();
    c.value.add(0);
  }
  //print(c.value);

  c = leadingzeros(c);
  return c;
}




void main() {
  //var asdf = new num_p.string('18349276');
  //var hjkl = new num_p.string("123456789123456789123456789123456789.123456789123456789");
  //var qwer = new num_p.string('4503599627370496.4568423185674564512');

  var asdf = new num_p.string('987654321987654324.789644');
  var qwer = new num_p.string('123654321000000000.5689');
  var zxcv = new num_p.string("864000000000000000");

  //print(asdf.value);
  //print(asdf.decimal);
  //print(qwer.value);
  //print(qwer.decimal);
  //print(zxcv.value);

  var uiop = subtract_stupid(asdf, qwer);
  print('uiop val: ${uiop.value}');
  print('uiop decimal: ${uiop.decimal}');
  print('uiop sign: ${uiop.neg}');
}
