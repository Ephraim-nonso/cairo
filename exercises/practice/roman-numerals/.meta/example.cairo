use core::fmt::{Display, Error, Formatter};

#[derive(Drop)]
pub struct Roman {
    value: ByteArray,
}

impl U32IntoRoman of Into<u32, Roman> {
    #[must_use]
    fn into(self: u32) -> Roman {
        // it will soon be possible to use constant array variables
        // for now we have to define them within the function
        let mut roman_map: Span<(u32, ByteArray)> = array![
            (1000, "M"),
            (900, "CM"),
            (500, "D"),
            (400, "CD"),
            (100, "C"),
            (90, "XC"),
            (50, "L"),
            (40, "XL"),
            (10, "X"),
            (9, "IX"),
            (5, "V"),
            (4, "IV"),
            (1, "I"),
        ]
            .span();

        let mut value: ByteArray = "";
        let mut current_num = self;
        for pair in roman_map {
            let (numeric, roman_string) = pair;
            while current_num >= *numeric {
                value.append(roman_string);
                current_num -= *numeric;
            }
        };

        Roman { value }
    }
}

impl RomanDisplay of Display<Roman> {
    fn fmt(self: @Roman, ref f: Formatter) -> Result<(), Error> {
        write!(f, "{}", self.value)
    }
}
