class Validation {
  String validatePassword(String pass1, String pass2) {
    if(pass1 != pass2) {
      return 'Cek ulang password';
    }
    return null;
  }
}