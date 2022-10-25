import 'dart:async';

import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../app/functions.dart';
import '../../../domain/usecase/forget_password_usecase.dart';
import '../../common/state_renderer/state_remderer_impl.dart';
import '../../common/state_renderer/state_renderer.dart';

class ForgetPasswordViewModel extends BaseViewModel with ForgetPasswordViewModelInputs,ForgetPasswordViewModelOutputs {

  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _allValidStreamController = StreamController<void>.broadcast();

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  var email="";

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _allValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //inputs

  @override
  Sink get inputEmail => _emailStreamController.sink;
  @override
  Sink get inputAllValid => _allValidStreamController.sink;

  //outputs

  @override
  Stream<bool> get outISEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<bool> get outISAllValid => _allValidStreamController.stream.map((_) =>isAllValid() );


  @override
  forgetPassword() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.execute((email))).fold(
    (failure) {
    // left
    inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
    },
    (data) {
      inputState.add(SuccessState(data));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email=email;
    _validate();
  }

  isAllValid() {
    return isEmailValid(email);
  }

   _validate() {
    inputAllValid.add(null);
   }

}

abstract class ForgetPasswordViewModelInputs{
  setEmail(String email);
  forgetPassword();

  Sink get inputEmail;
  Sink get inputAllValid;
}

abstract class ForgetPasswordViewModelOutputs{
  Stream<bool> get outISEmailValid;
  Stream<bool> get outISAllValid;

}