import 'lib/longnum.dart';


void main() {

  var c = new longnum.string('1234560780978798789078978907890789.987654321');
  var b = new longnum.string('12345890809809809779887986.6545266');

  //print(c.hashCode);
  //print(b.hashCode);
  //print(c == b);

  //print(add_master(c, b).value);
  //print(long_multi(c, b).value);

  print((c + b).value);
}
