import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput,Authentication>{
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(RegisterUseCaseInput input) async{
    return await _repository.register(RegisterRequest(input.name,input.countryMobileCode,input.mobileNumber,input.email,input.password,input.profilePicture));
  }
}

class RegisterUseCaseInput{
  String name;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  String countryMobileCode;
  RegisterUseCaseInput(this.name,this.countryMobileCode,this.mobileNumber,this.email,this.password,this.profilePicture);
}