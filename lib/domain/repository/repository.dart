import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/requests.dart';

import '../../data/network/failure.dart';
import '../model/models.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,String>> forgetPassword(String email);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure,HomeObject>> home();
  Future<Either<Failure,StoreObject>> storeDetails();
  Future<Either<Failure,NotificationModel>> notification();


}