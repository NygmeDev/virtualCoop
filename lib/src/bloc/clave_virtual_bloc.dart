import 'package:rxdart/rxdart.dart';
import 'package:virtual_coop/src/bloc/validators.dart';

class ClaveVirtualBloc with Validators {
  static final ClaveVirtualBloc _singleton = new ClaveVirtualBloc._internal();

  factory ClaveVirtualBloc() {
    return _singleton;
  }

  ClaveVirtualBloc._internal();

  final _passwordActualController = BehaviorSubject<String>();
  final _newPasswordController = BehaviorSubject<String>();
  final _repeatPasswordController = BehaviorSubject<Map<String, String>>();

  Stream<String> get passwordActualStream =>
      _passwordActualController.stream.transform(validarPassword);
  Stream<String> get newPasswordStream =>
      _newPasswordController.stream.transform(validarPassword);
  Stream<String> get repeatPasswordStream =>
      _repeatPasswordController.stream.transform(validarRepeatPassword);

  Stream<bool> get formValidStream => CombineLatestStream.combine3(
      passwordActualStream,
      newPasswordStream,
      repeatPasswordStream,
      (s1, s2, s3) => true);

  Function(String) get changePasswordActual =>
      _passwordActualController.sink.add;
  Function(String) get changeNewPassword => _newPasswordController.sink.add;
  Function(Map<String, String>) get changeRepeatNewPassword =>
      _repeatPasswordController.sink.add;

  String get passwordActual => _passwordActualController.value;
  String get newPassword => _newPasswordController.value;
  String get repeatPassword =>
      _repeatPasswordController.value['repeatPassword'] ?? "";

  dispose() {
    _passwordActualController.close();
    _newPasswordController.close();
    _repeatPasswordController.close();
  }
}
