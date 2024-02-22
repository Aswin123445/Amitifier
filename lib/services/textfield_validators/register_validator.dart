class RegisterValidator {
  String? nameValidator(String? name) {
    RegExp numberChecker = RegExp(r'\d');
    RegExp limitChecker = RegExp(r'^.{4,}$');

    if (name!.isEmpty) {
      return 'This field is required';
    }
    if (numberChecker.hasMatch(name)) {
      return 'This fiel can\'t have decimal';
    }
    if (!limitChecker.hasMatch(name)) {
      return 'atleast have 4 charater';
    }
    return null;
  }

  String? emailValidator(String? email) {
    final emailRegex =
        RegExp(r'^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$');
    if (email!.isEmpty) {
      return 'Must type Mail id';
    }
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid mail';
    }

    return null;
  }

  String? passwordValidator(String? email) {
    final passwordSpecialCharater = RegExp(r'[^a-zA-Z0-9]');
    final passwordNumberCharater = RegExp(r'\d');
    final passwordCapitalCharater = RegExp(r'[A-Z]');
    final passwordLength = RegExp(r'.{5,}');
    if (email!.isEmpty) {
      return 'Must type password ';
    }
    if (!passwordSpecialCharater.hasMatch(email)) {
      return 'Must conain 1 special charater';
    }
    if (!passwordNumberCharater.hasMatch(email)) {
      return 'Must contain 1 number';
    }
    if (!passwordCapitalCharater.hasMatch(email)) {
      return "must contain 1 captial";
    }
    if (!passwordLength.hasMatch(email)) {
      return "must conain atleast 5 charters";
    }

    return null; // No errors
  }
}
