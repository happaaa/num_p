import 'package:longnum/longnum.dart';



void main() {
  //var c = new Longnum.string('451011121834927612.98766543219876544');
  //var b = new Longnum.string('1234567891011121218646999999992.666665');
  //var a = new Longnum.string('12.0000083648');
  //var z = new Longnum.number(12.005);
  //var t = new Longnum.number(1834927658456);
  //var u = new Longnum.number(49);
  //var A = new Longnum.string('12');
  //var B = new Longnum.string('183492765672943811834927667381943');
  //var C = new Longnum.string('18349276.34178895');
  //var D = new Longnum.string('0.555555555963489284464');
  //var E = new Longnum.string('123456789987654321123456789987654321.183492765672943888995656');
  //var F = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
  //var G = new Longnum();

  print((new Longnum.number(-3) % new Longnum.number(10)).val);
  print(-111%10);

  print((new Longnum.string('4').squareroot()).val);
}

/*
 * fail if:
 * ends in 2, 3, 7, 8
 * terminates in odd number of 0s
 * end in 6 and 10s digit is even
 * doesn't end in 6 and 10s digit is odd
 * ends in 5 and 10s digit isn't 2
 * last 2 digits not divisible if is even
 */
exacttest(Longnum number) {

}
