import 'longnum.dart';

void test() {

  var emptyLongnum = new Longnum();
  assert(emptyLongnum.neg == false);
  assert(emptyLongnum.integer.length == 1 && emptyLongnum.integer[0] == 0);
  assert(emptyLongnum.decimal.length == 1 && emptyLongnum.decimal[0] == 0);

  var stringLongnum = new Longnum.string('-123456789123456789987654321.1234569876543211234567899987654321');
  emptyLongnum.value = '-123456789123456789987654321.1234569876543211234567899987654321';
  assert(stringLongnum.hashCode == 124197728399061);
  assert(emptyLongnum.hashCode == stringLongnum.hashCode);

  var doubleLongnum = new Longnum.number(132654789.924785);
  var doubl_Longnum = new Longnum.number(132654789.924784);
  var intLongnum = new Longnum.number(-927618345926405);
  assert(doubleLongnum.neg == false && doubleLongnum.integer.length == 1 && doubleLongnum.integer[0] == 132654789);
  assert(doubleLongnum.decimal.length == 1 && doubleLongnum.decimal[0] == 924785000000000);
  assert(intLongnum.neg == true && intLongnum.integer.length == 1 && intLongnum.integer[0] == 927618345926405);
  assert(intLongnum.decimal.length == 1 && intLongnum.decimal[0] == 0);

  assert(emptyLongnum == stringLongnum);
  assert(emptyLongnum >= stringLongnum);
  assert(emptyLongnum <= stringLongnum);
  assert(doubleLongnum > intLongnum);
  assert(doubleLongnum >= intLongnum);
  assert(intLongnum < doubleLongnum);
  assert(intLongnum <= doubleLongnum);
  assert(stringLongnum < doubleLongnum);
  assert(stringLongnum <= doubleLongnum);
  assert(doubleLongnum > doubl_Longnum);
  assert(doubl_Longnum <= doubleLongnum);
  intLongnum.neg = false;
  assert(intLongnum > doubleLongnum);
  assert(intLongnum >= doubleLongnum);
  assert(intLongnum > stringLongnum);
  assert(stringLongnum <= intLongnum);










  print('All tests passed successfully');
}
