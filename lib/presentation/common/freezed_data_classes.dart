import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String name,String password)=_LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject(String name,String countryMobileCode,String mobilePhone,String email,String password,String profilePicture)=_RegisterObject;
}
