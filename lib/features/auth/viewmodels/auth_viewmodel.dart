import 'package:universe_app/core/viewmodels/base_viewmodel.dart';
import 'package:universe_app/features/auth/models/user_model.dart';
import 'package:universe_app/features/auth/repositories/auth_repository.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel(this._repository);

  final AuthRepository _repository;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<bool> login({required String email, required String password}) async {
    setError(null);
    setLoading(true);

    try {
      _currentUser = await _repository.login(email: email, password: password);
      return true;
    } catch (error) {
      setError(error.toString().replaceFirst('Exception: ', ''));
      return false;
    } finally {
      setLoading(false);
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
