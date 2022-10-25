import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';

import '../../../app/functions.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../base/base_view_model.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_remderer_impl.dart';
import '../../common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInputs,RegisterViewModelOutputs{

  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _mobilePhoneStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _allValidStreamController = StreamController<void>.broadcast();
  final StreamController isUserRegisterSuccessfullyStreamController = StreamController<bool>();


  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  var registerObject=RegisterObject("","","","","","");


  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _mobilePhoneStreamController.close();
    _emailStreamController.close();
    _profilePictureStreamController.close();
    _passwordStreamController.close();
    _allValidStreamController.close();
    isUserRegisterSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  // inputs

  @override
  Sink get inputAllValid => _allValidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobilePhone => _mobilePhoneStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController;

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)){
      registerObject=registerObject.copyWith(email: email);
    }else
    {
      registerObject=registerObject.copyWith(email: "");
    }
    inputAllValid.add(null);
  }

  @override
  setMobilePhone(String mobilePhone) {
    inputMobilePhone.add(mobilePhone);
    if(_isMobilePhoneValid(mobilePhone)){
      registerObject=registerObject.copyWith(mobilePhone: mobilePhone);
    }else
    {
      registerObject=registerObject.copyWith(mobilePhone: "");
    }
    inputAllValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      registerObject=registerObject.copyWith(password: password);
    }else
    {
      registerObject=registerObject.copyWith(password: "");
    }
    inputAllValid.add(null);
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty){
      registerObject=registerObject.copyWith(profilePicture: profilePicture.path);
    }else
    {
      registerObject=registerObject.copyWith(profilePicture: "");
    }
    inputAllValid.add(null);
  }

  @override
  setUserName(String name) {
    inputUserName.add(name);
    if(_isUserNameValid(name)){
      registerObject=registerObject.copyWith(name: name);
    }else
    {
      registerObject=registerObject.copyWith(name: "");
    }
    inputAllValid.add(null);
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    if(countryMobileCode.isNotEmpty){
      registerObject=registerObject.copyWith(countryMobileCode: countryMobileCode);
    }else
    {
      registerObject=registerObject.copyWith(countryMobileCode: countryMobileCode);
    }
    inputAllValid.add(null);
  }

  //outputs

  @override
  Stream<bool> get outISAllValid => _allValidStreamController.stream.map((_) => _isAllValid());

  @override
  Stream<bool> get outISEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outISMobilePhoneValid => _mobilePhoneStreamController.stream.map((mobilPhone) => _isMobilePhoneValid(mobilPhone));

  @override
  Stream<bool> get outISPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<File> get outISProfilePictureValid => _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outISUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorEmail => outISEmailValid.map((isEmail) => isEmail ? null : AppStrings.emailError.tr().tr());

  @override
  Stream<String?> get outputErrorMobilePhone => outISMobilePhoneValid.map((isMobilePhone) => isMobilePhone ? null :AppStrings.phoneError.tr());

  @override
  Stream<String?> get outputErrorPassword => outISPasswordValid.map((isPassword) => isPassword ? null :AppStrings.passwordInvalid.tr());

  @override
  Stream<String?> get outputErrorUserName => outISUserNameValid.map((isUserName) => isUserName ? null :AppStrings.userNameValid.tr());



  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
      (await _registerUseCase.execute(RegisterUseCaseInput(registerObject.name,
      registerObject.countryMobileCode,registerObject.mobilePhone,registerObject.email,
          registerObject.password,registerObject.profilePicture))).fold(
              (failure) {
            // left
            inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
          },
              (data) {
            inputState.add(ContentState());
            isUserRegisterSuccessfullyStreamController.add(true);
          });
  }



  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isAllValid() {
    return registerObject.name.isNotEmpty&&registerObject.countryMobileCode.isNotEmpty&&
    registerObject.mobilePhone.isNotEmpty&&registerObject.email.isNotEmpty&&
    registerObject.password.isNotEmpty&&registerObject.profilePicture.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _isMobilePhoneValid(String mobilPhone) {
    return mobilPhone.length >= 10;
  }

}



abstract class RegisterViewModelInputs{
  setUserName(String name);
  setCountryMobileCode(String countryMobileCode);
  setMobilePhone(String mobilePhone);
  setPassword(String password);
  setEmail(String email);
  setProfilePicture(File profilePicture);
  register();

  Sink get inputUserName;
  Sink get inputMobilePhone;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllValid;
}

abstract class RegisterViewModelOutputs{
  Stream<bool> get outISUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outISMobilePhoneValid;
  Stream<String?> get outputErrorMobilePhone;

  Stream<bool> get outISEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<File> get outISProfilePictureValid;

  Stream<bool> get outISPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outISAllValid;
}