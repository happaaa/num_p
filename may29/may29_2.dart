import 'dart:math';

class num_p {
  static final E = [2, '.', 7, 1, 8, 2, 8, 1, 8, 2, 8, 4, 5, 9, 0 ,4, 5, 2, 3, 5, 3, 6, 0, 2, 8, 7, 4, 7,
                        1, 3, 5, 2, 6, 6, 2, 4, 9, 7, 7, 5, 7, 2, 4, 7, 0, 9, 3, 6, 9, 9, 9, 5, 9, 5, 7, 4, 9, 6, 6];
  static final E_string = "2.718281828459045235360287471352662497757247093699959574966";
  static final PI_string = "3.141592653589793238462643383279502884197169399375105820974";
  static final LN2_string = "0.693147180559945309417232121458176568075500134360255254120";
  static final LN10_string = "2.302585092994045684017991454684364207601101488628772976033";
  static final LOG2E_string = "1.442695040888963407359924681001892137426645954152985934135";
  static final LOG10E_string = "0.434294481903251827651128918916605082294397005803666566114";
  static final SQRT1_2_string = "0.707106781186547524400844362104849039284835937688474036588";
  static final SQRT2_string = "1.414213562373095048801688724209698078569671875376948073176";

 	var number = new List();

  // constructor from string
  num_p(String string) {
    for (int i = 0; i < string.length; i++) {
      number.add(int.parse(string[i]));
    }
  }

  // getter
  get_number() {
    return number;
  }

  // setter
  set_number(String string) {
    number.clear();
    for (int i = 0; i < string.length; i++) {
      number.add(int.parse(string[i]));
    }
  }

  //to_num() {
  //  var val =
  //}
}

add(var a, var b) {
  var length = min(a.length, b.length);
  var c = new List();

  for (int i = 0; i < length; i++) {
    c.add(0);
    c[i] = a[a.length - 1] + b[b.length - 1];
    if (c[i] >= 10) {
      c.add(1);
    }
  }
}

subtract(var a, var b) {

}

multiply(var a, var b) {

}

divide(var a, var b) {

}

void main() {
  print(E);

  var nu_E = new List();
  var string_E = E.toString();

  print(string_E.length);

  var really = new num_p('1234');
  print(num_p.E.length);
}
