import 'lib/src/num_p.dart';

// formatting
num_p leadingzeros_nump(num_p number) {
  //number.value = (number.value.reversed).toList();
  //number.decimal = (number.decimal.reversed).toList();
  var k = number.value.length, l = number.decimal.length;
  for (var u = 0; u < k && number.value.first == 0; u++) {
    number.value.removeAt(0);
  }
  for (var v = 0; v < l && number.decimal.first == 0; v++) {
    number.decimal.removeAt(0);
  }
  return number;
}

List leadingzeroslist(List number) {
  //number.value = (number.value.reversed).toList();
  var k = number.length;
  for (var u = 0; u < k && number.first == 0; u++) {
    number.removeAt(0);
  }
  return number;
}

trailingzeros(num_p number) {

}
