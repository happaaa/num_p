import 'lib/longnum.dart';
import 'lib/test.dart';



void main() {

  //var c = new Longnum.string('1834927612.987665432198765');
  var b = new Longnum.string('1234567891011121218646999999992.666665');
  //var a = new Longnum.string('12.0000083648');
  //var z = new Longnum.number(12.005);

  //newton_better(0.522223, 9);

  print(b.val);
  print(b.val.hashCode);
  print([false, [1, 234567891011121, 218646999999992], [666665000000000]].hashCode);
  print(b.hashCode);
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
    //print('zk: $zk');
  }
  print(zk);
}
