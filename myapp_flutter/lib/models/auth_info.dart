class AuthInfo {
  String value;
  bool valid;
  bool touched;
  Function validator;

  AuthInfo({
    this.value = "",
    this.valid = false,
    this.touched = false,
    this.validator,
  });
}
