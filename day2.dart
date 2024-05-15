void main() {
  bool isPalindrome(int x) {
    if (x < 0) {
      return false;
    } else {
      String xReversed = x.toString().split('').reversed.join();
      int xIsPalindrome = int.parse(xReversed);
      if (x == xIsPalindrome) {
        return true;
      } else {
        return false;
      }
    }
  }

  isPalindrome(-313);
}
