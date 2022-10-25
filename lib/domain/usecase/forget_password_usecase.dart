import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ForgetPasswordUseCase implements BaseUseCase<String,String>{
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String input) async{
    return await _repository.forgetPassword((input));
  }
}