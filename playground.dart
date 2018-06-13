import 'lib/longnum.dart';


void main() {

    //print(two_by_one([456, 74, 563], [540, 545], 3));
    //print(long_div_sub([456, 74], [545], 3));
    var a = [1, 2, 3, 4];
    var b = a;
    for (var i = 0; i < 6; i++) {
      a.add(b.last);
    }
    print(a);

    print(power_list([43, 5], 4, 2));
}
