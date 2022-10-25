import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../app/constants.dart';
import '../response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient{
  factory AppServicesClient(Dio dio,{String baseUrl}) = _AppServicesClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password
      );

  @POST("/customers/forgotPassword")
  Future<ForgetPasswordResponse> forgetPassword(
      @Field("email") String email,
      );

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String name,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture,
      );

  @GET("/home")
  Future<HomeResponse> home();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> storeDetails();

  @GET("/notification/1")
  Future<NotificationsResponse> notifications();
}