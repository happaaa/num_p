import 'lib/longnum.dart';


void main() {

  var c = new num_p.string('1234560780978798789078978907890789.987654321');
  var b = new num_p.string('12345890809809809779887986.6545266');

  //print(c.hashCode);
  //print(b.hashCode);
  //print(c == b);

  //print(add_master(c, b).value);
  //print(long_multi(c, b).value);

  print(long_div([34, 456, 123, 874], [634, 678, 153], 3));
}
