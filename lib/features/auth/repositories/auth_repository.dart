import 'package:universe_app/features/auth/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<UserModel> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Email and password are required.');
    }

    return UserModel(
      id: 'mock-user-1',
      email: email,
      fullName: 'Student User',
      role: 'student',
    );
  }
}
