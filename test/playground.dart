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

  var four = new Longnum.string('278948165489748153187984231348486423187987454123138786110000');
  var fourdeci = new Longnum.string('0.165242943727489785247560980598817188932162690665753698040481');

  print((four/fourdeci).val);

  //three_by_two([22641853395002, 270479659737216, 156628250335378, 0, 0], [660971774909959, 140990243922395, 268755728650762]);



}
