import 'lib/longnum.dart';



void main() {

  var c = new Longnum.string('451011121834927612.98766543219876544');
  var b = new Longnum.string('1234567891011121218646999999992.666665');
  //var a = new Longnum.string('12.0000083648');
  //var z = new Longnum.number(12.005);
  //var t = new Longnum.number(1834927658456);
  //var u = new Longnum.number(49);

  //var a = 18349276, z = 92997;
  //var x = newton_better(z * pow(10, -5), 6);
  //print((x * pow(10, 3)).floor());
  //var ans = barrett(a, z, (x * pow(10, 3)).floor());
  //print(ans);

  //babylon(12345678998765);
  //print(ln_list_approx([7, 999918649276448, 7779], 7));
  //print(babylonlist([4568137, 0, 7779]));
  //print(squaring([2137, 320050904870915]));
  //print(c.val);
  //print(b.val);
  //print(multimaster(c, b).val);
  //print(add_int([987, 456], [234, 111], power: 3));
  print(subtract_master(b, c).val);

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
    tk = v; //- (v % pow(10, - (2 * i + 3)));
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
  return zk;
}
