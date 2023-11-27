class AuthService {
  Future<bool> authenticate(String email, String password) async {
    await Future.delayed(Duration(seconds: 2)); 

    if (email == 'user@example.com' && password == 'password') {
      return true; 
    } else {
      return false;
    }
  }
}
