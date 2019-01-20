import '../models/models.dart';

class AuthRemoveTokenAction {}

class AuthSetTokenAction {
  final Auth auth;

  AuthSetTokenAction({this.auth});
}
