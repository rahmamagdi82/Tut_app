import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/model/models.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<void,StoreObject>{
  final Repository _repository;
  StoreDetailsUseCase(this._repository);
  @override
  Future<Either<Failure, StoreObject>> execute(void input) async{
    return await _repository.storeDetails();
  }
}