import Int "mo:base/Int";
import Debug "mo:base/Debug";

// Calculator

actor calculator {
    var digit: Int = 0; // var -> mutable, let -> immutable

    //summation
    public func summation(s: Int) : async Int {
        digit += s;
        digit
        //(Debug.print(debug_show (digit));)
    };

    //substraction
    public func substraction(s: Int) : async Int {
        digit -= s;
        digit;
    };

    //multiplication
    public func multiplication(s: Int) : async Int {
        digit *= s;
        digit;
    };

    //dividing
    public func dividing(s: Int) : async ?Int {
        if (s == 0) {
            null
        } else {
            digit /= s;
            ?digit;
        }
    };

    //CLEAR
    public func clear() : async () {
        digit := 0;
    };

};