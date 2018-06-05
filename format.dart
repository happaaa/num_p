import 'num_p.dart';

num_p leadingzeros(num_p number) {
  // formatting
  number.value = (number.value.reversed).toList();
  number.decimal = (number.decimal.reversed).toList();
  var k = number.value.length, l = number.decimal.length;
  for (var u = 0; u < k && number.value[0] == 0; u++) {
    number.value.removeAt(0);
  }
  for (var v = 0; v < l && number.decimal[0] == 0; v++) {
    number.decimal.removeAt(0);
  }
  return number;
}

trailingzeros(num_p number) {
  
}
