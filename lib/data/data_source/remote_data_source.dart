import 'package:tut_app/data/network/app_api.dart';

import '../network/requests.dart';
import '../response/responses.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgetPasswordResponse> forgetPassword(String forgetPasswordRequest);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> home();

  Future<StoreDetailsResponse> storeDetails();

  Future<NotificationsResponse> notification();

}

class RemoteDataSourceImp implements RemoteDataSource{

  final AppServicesClient _appServicesClient;
  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async{
    return await _appServicesClient.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async{
    return await _appServicesClient.register(registerRequest.name, registerRequest.countryMobileCode, registerRequest.mobileNumber, registerRequest.email, registerRequest.password, "");
  }

  @override
  Future<HomeResponse> home() async {
    return await _appServicesClient.home();
  }

  @override
  Future<StoreDetailsResponse> storeDetails() async {
    return await _appServicesClient.storeDetails();

  }

  @override
  Future<NotificationsResponse> notification() async{
    return await _appServicesClient.notifications();
  }
}