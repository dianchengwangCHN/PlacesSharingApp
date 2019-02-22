bool minLenValidator(String val, int len) {
  if (val.length < len) {
    return false;
  }
  return true;
}

bool equalToValidator(String val, String target) {
  if (val != target) {
    return false;
  }
  return true;
}

bool isEmailValidator(String val) {
  RegExp regExp = RegExp(
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(val);
}
