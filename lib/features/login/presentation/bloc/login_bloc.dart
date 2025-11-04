import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/check_login_status_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;
  final LogoutUseCase logoutUseCase;

  LoginBloc({required this.loginUseCase, required this.checkLoginStatusUseCase, required this.logoutUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLogin);
    on<CheckLoginStatus>(_onCheckStatus);
    on<LogoutButtonPressed>(_onLogout);
  }

  Future<void> _onLogin(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final success = await loginUseCase(event.username, event.password);
    if (success) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('Invalid credentials'));
    }
  }

  Future<void> _onCheckStatus(CheckLoginStatus event, Emitter<LoginState> emit) async {
    final loggedIn = await checkLoginStatusUseCase();
    if (loggedIn) {
      emit(LoginSuccess());
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> _onLogout(LogoutButtonPressed event, Emitter<LoginState> emit) async {
    await logoutUseCase();
    emit(LoginInitial());
  }
}
