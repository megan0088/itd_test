class LoginController {
  // Simulasi fungsi login
  void login(String email, String password) {
    if (email == 'admin' && password == 'admin') {
      print('Login Berhasil');
    } else {
      print('Login Gagal');
    }
  }
}
