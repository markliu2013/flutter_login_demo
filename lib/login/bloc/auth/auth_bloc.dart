import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/login/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginRepository loginRepository;

  AuthBloc({
    required this.loginRepository,
  }) : super(AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedOut>(_onLoggedOut);
    on<LoggedIn>(_onLoggedIn);
  }

  void _onAppStarted(_, Emitter<AuthState> emit) async {
    final String token = await loginRepository.getToken();
    if (token.isNotEmpty) {
      try {
        User user = await loginRepository.getSession();
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      } catch (_) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
        ));
      }
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
      ));
    }
  }

  void _onLoggedOut(_, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    await loginRepository.deleteToken();
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
    ));
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    await loginRepository.saveToken(event.token);
    emit(state.copyWith(
      status: AuthStatus.authenticated,
      user: await loginRepository.getSession(),
    ));
  }

}