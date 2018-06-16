class num_p {
  static final E_string =
      "2.718281828459045235360287471352662497757247093699959574966";
  static final PI_string =
      "3.141592653589793238462643383279502884197169399375105820974";
  static final LN2_string =
      "0.693147180559945309417232121458176568075500134360255254120";
  static final LN10_string =
      "2.302585092994045684017991454684364207601101488628772976033";
  static final LOG2E_string =
      "1.442695040888963407359924681001892137426645954152985934135";
  static final LOG10E_string =
      "0.434294481903251827651128918916605082294397005803666566114";
  static final SQRT1_2_string =
      "0.707106781186547524400844362104849039284835937688474036588";
  static final SQRT2_string =
      "1.414213562373095048801688724209698078569671875376948073176";

  // either have two lists, one before decimal and one after
  // 		or make it a string and parse it every time i do an operation
  // also wondering it having more than 1 digit per position is worth it
  var value = new List();
  var decimal = new List();
  bool neg = false;

  // default constructor (don't really need this)
  num_p() {
    value = [0];
    decimal = [0];
    neg = false;
  }

  // constructor from string
  num_p.string(String string) {
    int i = 0;
    var string_list;

    if (string.startsWith('-')) {
      neg = true;
      i = 1;
    }
    string_list = string.split('.');

    for (i; i < string_list[0].length; i += 15) {
      value.add((i + 15 > string_list[0].length) ? int.parse(string_list[0].substring(i, string_list[0].length))
                                                 : int.parse(string_list[0].substring(i, i + 15)));
    }
    if (string_list.length == 2) {
      for (i = 0; i < string_list[1].length; i += 15) {
        decimal.add((i + 15 > string_list[1].length) ? int.parse(string_list[1].substring(i, string_list[1].length))
                                                     : int.parse(string_list[1].substring(i, i + 15)));
      }
    }
  }

  // constructor from num
  // might have to change from convert to string and back to int
  num_p.number(num number) {
    if (number.isNegative) {
      neg = true;
      number = number.abs();
    }
    var string_list = (number.toString()).split('.');
    if (string_list.length == 2) {
      decimal.add(int.parse(string_list[1]));
    }
    value.add(number.floor());
  }

  // setter from string
  set string(String string) {
    value.clear();
    decimal.clear();
    neg = false;

    int i = 0;
    var string_list;

    if (string.startsWith('-')) {
      neg = true;
      i = 1;
    }
    string_list = string.split('.');

    for (i; i < string_list[0].length; i += 15) {
      value.add((i + 14 > string_list[0].length) ? int.parse(string_list[0].substring(i, string_list[0].length))
                                                 : int.parse(string_list[0].substring(i, i + 14)));
    }
    if (string_list.length == 2) {
      for (i = 0; i < string_list[1].length; i += 15) {
        decimal.add((i + 14 > string_list[1].length) ? int.parse(string_list[1].substring(i, string_list[1].length))
                                                     : int.parse(string_list[1].substring(i, i + 14)));
      }
    }
  }




}
