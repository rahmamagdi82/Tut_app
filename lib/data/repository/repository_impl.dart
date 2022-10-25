import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/repository/repository.dart';

import '../network/error_handler.dart';

class RepositoryImpl extends Repository{
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource,this._networkInfo,this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{

    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiStatues.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiStatues.FAILUER, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
      else
      {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgetPassword(email);
        if (response.status == ApiStatues.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiStatues.FAILUER, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiStatues.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiStatues.FAILUER, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else
    {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> home() async {
    try{
      final response = await _localDataSource.home();
      return Right(response.toDomain());
    }catch(cacheError){
      if(await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.home();
          if (response.status == ApiStatues.SUCCESS) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ApiStatues.FAILUER, response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
      else
      {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
    }

  @override
  Future<Either<Failure, StoreObject>> storeDetails() async {
    try{
      final response = await _localDataSource.storeDetails();
      return Right(response.toDomain());
    }catch(cacheError){
      if(await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.storeDetails();
          if (response.status == ApiStatues.SUCCESS) {
            _localDataSource.saveStoreToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ApiStatues.FAILUER, response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
      else
      {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NotificationModel>> notification() async {
    try{
      final response = await _localDataSource.notification();
      return Right(response.toDomain());
    }catch(cacheError){
      if(await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.notification();
          if (response.status == ApiStatues.SUCCESS) {
            _localDataSource.saveNotificationsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ApiStatues.FAILUER, response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
      else
      {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }




}