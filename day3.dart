int romanToInt(String s) {
  Map<String, int> romanValues = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000
  };

  int result = 0;
  int prevValue = 0;

  for (int i = s.length - 1; i >= 0; i--) {
    int value = romanValues[s[i]]!;

    if (value < prevValue) {
      result -= value;
    } else {
      result += value;
    }

    prevValue = value;
  }

  return result;
}

void main() {
  String s1 = "IIX";
  String s2 = "LVIII";
  String s3 = "MCMXCIV";

  print("Input: $s1, Output: ${romanToInt(s1)}");
  print("Input: $s2, Output: ${romanToInt(s2)}");
  print("Input: $s3, Output: ${romanToInt(s3)}");
}
