import 'package:universe_app/features/auth/repositories/auth_repository.dart';

class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator instance = ServiceLocator._();

  late final AuthRepository authRepository;

  void setup() {
    authRepository = MockAuthRepository();
  }
}
