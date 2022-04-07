import 'package:rxdart/rxdart.dart';
import 'package:virtual_coop/src/bloc/validators.dart';

class LoginBloc with Validators {
  static final LoginBloc _singleton = new LoginBloc._internal();

  factory LoginBloc() {
    return _singleton;
  }

  LoginBloc._internal();

  final _userController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get userStream =>
      _userController.stream.transform(validarUserName);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(userStream, passwordStream, (e, p) => true);

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get user => _userController.value;
  String get password => _passwordController.value;

  dispose() {
    _userController.close();
    _passwordController.close();
  }
}
