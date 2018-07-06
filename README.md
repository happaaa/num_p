# longnum
Arbitrary precision arithmetic package for Dart.

Contains most functions in the math package.
Work in progress. Most recent updates will be on the **testing** branch.


It supports:
-   Addition
-   Subtraction
-   Multiplication
-   Division
-   Modulo
-   Powers
-   Square root
-   Exponential function
-   Natural logarithm
-   Comparison operators (>, <=, ==, etc.)
-   Maximum and minimum
-   Absolute value
-   Trig functions


### Works in progress/Bugs

-   Modulo function doesn't give correct answer with negative numbers
-   Create a more accurate natural logarithm function that works with decimals
-   Give exact answers for exact squares for square root function
-   Power functions doesn't receive negative integer inputs as powers (i.e. 5^-2);


### Future improvements

-   Combine integer and decimal lists and add a radix variable instead?
-   Implement Jebelean exact division algorithm
-   Implement Newton division
-   Set each digits closer to the *num* class size limit to improve efficiency
-   Make code much cleaner and concise to improve speed
