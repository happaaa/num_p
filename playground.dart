import 'lib/longnum.dart';
import 'lib/test.dart';


void main() {

  var c = new Longnum.string('1834927612.987665432198765');
  var b = new Longnum.string('1234567891011121218646999999992.666665');
  var a = new Longnum.string('12.0000083648');
  var z = new Longnum.number(12.005);

  //print(long_div([48645, 19, 29445], [56], 5));
  //print(c.val);
  //print(b.val);
  //multimaster(c, b);

  print(longdiv([1834927, 7294381, 4444444, 4381672], [46, 5555555], 7));
  //print("BREAK");
  //print(div_sub_helper([46777], [862254, 46], 6));
  //print(two_by_one([1834927, 7294381, 4381672], [46, 5555555], 7));\

  //print(divmain([1834927, 7294381, 4381672], [46, 5555555], 7));

}


longdiv(List a, List b, [int power = 15]) {
  final BASE = pow(10, power);
  var constant = 1; // regulating divisor to be half of 10^power
  if (b[0] < BASE / 2) {
    constant = ((BASE / 2) / b[0]).ceil();
    b = multi_int(b, [constant], power: power);
    a = multi_int(a, [constant], power: power);
  }
  print('div a: $a');
  print('div b: $b');
  if (a.length < b.length) return [[0], a];
  if (a.length == b.length) {
    if (a[0] < b[0]) return [[0], a];
    else return [[1], [subtract_int(a, b, power: power)]];
  }
  if (a.length == b.length + 1) return div_sub(a, b, power);
  var bm = a.length - b.length - 1;
  var a_prime = a.sublist(0, a.length - bm);
  var s = a.sublist(a.length - bm, a.length);
  //print('a_prime: $a_prime');
  var prime = div_sub(a_prime, b, power); // somehow adds a 0 in front of b
  for (var i = 0; i < bm; i++) {
    prime[1].add(0);
  }
  //print('prime: $prime');
  //print('s: $s');
  var div = longdiv(add_int(prime[1], s, power: power), b, power);

  for (var i = 0; i < bm; i++) {
    prime[0].add(0);
  }
  var remainder = longdiv(div[1], [constant], power);
  //print('div: $div');
  return [add_int(prime[0], div[0], power: power), remainder[0]];
}


div_sub(List a, List b, [int power = 15]) {

  print('a: $a');
  print('new b: $b');
  //print('constant: $constant');
  if (a[0] > b[0]) {
    a = subtract_int(a, multi_int(b, [1, 0], power: power), power: power);
    var ans = div_sub(a, b, power);
    ans[0].insert(0, 1);
    return [ans[0], ans[1]];
  }
  var a_msb = [a[0], a[1]];
  var b_msb = [b[0]];

  var array = [];
  var b_msb_master = b_msb;
  while (compare_list(a_msb, b_msb_master) != 0) {
    var multiple;
    for (multiple = 0; compare_list(a_msb, multi_int(b_msb_master, [2], power: power)) != 0; multiple++) {
      b_msb_master = multi_int(b_msb_master, [2], power: power);
      //print('b multiple ${multiple + 1}: $b_msb_master');
    }
    a_msb = subtract_int(a_msb, b_msb_master, power: power);
    b_msb_master = b_msb;
    array.add(multiple);
  }
  //print(array);
  var q = 0;
  for (var i = 0; i < array.length; i++) {
    q += pow(2, array[i]);
  }
  //print(q);
  var t = multi_int([q], b, power: power);
  while (compare_list(t, a) == 1) {
    q -= 1;
    t = subtract_int(t, b, power: power);
  }
  t = subtract_int(a, t, power: power);



  //print(q);
  //print('t: $t');
  return [[q], t];
}
