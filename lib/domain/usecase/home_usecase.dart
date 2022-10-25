import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _repository.home();
  }
}