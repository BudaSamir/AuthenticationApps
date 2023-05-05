String? validateEmail(String? email) {
  String? msg;
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (email!.isEmpty) {
    msg = "Your Email is Required";
  } else if (regex.hasMatch(email)) {
    msg = "Please provide a valid emal address";
  }
  return msg;
}

String? validatePassword(String? password) {
  String? msg;
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (password!.isEmpty) {
    msg = "Your password is Required";
  } else if (regex.hasMatch(password)) {
    msg = "Please provide a valid password";
  }
  return msg;
}

String? validateConfirmPassword(String? password) {
  String? msg;
  msg = "Passwords not match";
  return msg;
}
