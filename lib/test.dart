import 'longnum.dart';

void test() {

  var emptyLongnum = new longnum();
  assert(emptyLongnum.neg == false);
  assert(emptyLongnum.integer.length == 1 && emptyLongnum.integer[0] == 0);
  assert(emptyLongnum.decimal.length == 1 && emptyLongnum.decimal[0] == 0);

  var stringLongnum = new longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
  assert(emptyLongnum.hashCode == stringLongnum.hashCode);






}
