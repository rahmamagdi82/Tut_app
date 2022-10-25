import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_remderer_impl.dart';
import '../../common/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs,LoginViewModelOutputs{

  final StreamController _usrNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _allValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>();


  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  var loginObject=LoginObject("","");


  @override
  void dispose() {
    super.dispose();
    _usrNameStreamController.close();
    _passwordStreamController.close();
    _allValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //inputs

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUseName => _usrNameStreamController.sink;

  @override
  Sink get inputAllValid => _allValidStreamController.sink;

  @override
  login() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.name, loginObject.password))).fold(
            (failure) {
              // left
              inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
              },
            (data) {
              inputState.add(ContentState());
              isUserLoggedInSuccessfullyStreamController.add(true);
            });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject=loginObject.copyWith(password: password);
    inputAllValid.add(null);
  }

  @override
  setUserName(String name) {
    inputUseName.add(name);
    loginObject=loginObject.copyWith(name: name);
    inputAllValid.add(null);
  }

  //outputs

  @override
  Stream<bool> get outISPasswordValid => _passwordStreamController.stream.map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outISUserNameValid => _usrNameStreamController.stream.map((userName) => isUserNameValid(userName));

  @override
  Stream<bool> get outISAllValid => _allValidStreamController.stream.map((_) => isAllValid());

  bool isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool isUserNameValid(String userName){
    return userName.isNotEmpty;
  }

  bool isAllValid(){
    return isPasswordValid(loginObject.password) && isUserNameValid(loginObject.name);
  }
}

abstract class LoginViewModelInputs{
  setUserName(String name);
  setPassword(String password);
  login();

  Sink get inputUseName;
  Sink get inputPassword;
  Sink get inputAllValid;
}

abstract class LoginViewModelOutputs{
  Stream<bool> get outISUserNameValid;
  Stream<bool> get outISPasswordValid;
  Stream<bool> get outISAllValid;
}