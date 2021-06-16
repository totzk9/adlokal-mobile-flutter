import 'package:adlokal/auth/domain/entities/email_address.dart';
import 'package:adlokal/auth/domain/entities/password.dart';

class SignUpService {
  // SignUpService(this.repository);

  // final Repository repository;

  Future<bool> signUp(String emailAddress, String password) async {
    if (emailAddress == 'email@gmail.com' && password == 'password') {
      return true;
    }
    return false;
  }
}