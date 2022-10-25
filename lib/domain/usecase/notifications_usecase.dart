import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/model/models.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class NotificationUseCase implements BaseUseCase<String,NotificationModel>{
  final Repository _repository;
  NotificationUseCase(this._repository);
  @override
  Future<Either<Failure, NotificationModel>> execute(void input) async{
    return await _repository.notification();
  }
}