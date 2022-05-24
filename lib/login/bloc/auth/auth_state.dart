part of 'auth_bloc.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthState extends Equatable {

  final AuthStatus status;
  final User? user;

  const AuthState({
    this.status = AuthStatus.uninitialized,
    this.user
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];

}
