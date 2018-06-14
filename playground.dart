import 'lib/longnum.dart';
import 'lib/test.dart';


void main() {

  var c = new Longnum.string('1834927612.987665432198765');
  var b = new Longnum.string('1218646.666665');
  var a = new Longnum.string('12.0000083648');
  var z = new Longnum.number(12.005);

  //print(long_div([48645, 19, 29445], [56], 5));
  babylon(524288, 20);
}

babylon(var number, var interation) {
  //var guess = number / 2;
  var guess = 700;
  for (var i = 0; i < interation; i++) {
    guess = (guess + number / guess) / 2;
    print('guess $i: $guess');
  }
  return guess;
}
