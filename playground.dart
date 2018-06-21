import 'lib/longnum.dart';



void main() {

  //var c = new Longnum.string('1834927612.987665432198765');
  //var b = new Longnum.string('1234567891011121218646999999992.666665');
  //var a = new Longnum.string('12.0000083648');
  //var z = new Longnum.number(12.005);
  //var t = new Longnum.number(1834927658456);
  //var u = new Longnum.number(49);

  //var res = long_div(t.integer, u.integer);
  //print('res: $res');
  //res[1].add(0);
  //var rem = long_div(res[1], u.integer);
  //print('rem: $rem');

  //newton_better(0.00486, 7);

  //babylon(18349276);
  print(barrettlist([1008465, 0], [4544, 0], [200000000000]));
  //print(squaring([0, 99500]));
}


List barrett(int a, int b, int mu) { // mu ~~ pow(BASE, a_size) / b
  const BASE = 10;
  var a_size = a.toString().length;
  var b_size = b.toString().length;

  // check the sizes of the strings

  var a1 = (a * pow(BASE, -(b_size - 1))).floor();
  var qk = (a1 * mu * pow(BASE, -(a_size - b_size + 1))).floor();
  var rk = a - b * qk;
  bool test = false;
  //print('q1: $q1');
  while(!test) {
    //print('qk: $qk');
    //print('rk: $rk');
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
    print('q: $qk and r: $rk');
  }
  return [qk, rk];
}


newton_better(num v, num n) {
  //var v_num = v.toString();
  var i = 1;
  var zk = (1 / v)  - ((1 / v) % pow(10 , -i));
  print('start zk: $zk');
  var sk, tk, uk, wk;
  for (i; i < n; i++) {
    sk = pow(zk, 2);
    //print('sk $i: $sk');
    tk = v - (v % pow(10, - (2 * i + 3)));
    //print('tk: $tk');
    uk = tk * sk;
    uk = uk - (uk % pow(10, - (2 * i + 1)));
    //print('uk: $uk');
    wk = 2 * zk;
    //print('wk: $wk');
    zk = wk - uk;
    print('zk: $zk');
  }
  print(zk);
}

newtonlist(List number, num iteration) {
  var i = 1;
  var zk = long_div([1, 0], number)[0];
  var sk, tk, uk, wk;
  for (i; i < iteration; i++) {
    sk = squaring(zk);

  }
}
