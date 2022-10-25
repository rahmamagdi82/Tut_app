import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../../../../domain/model/models.dart';
import '../../../../../common/state_renderer/state_remderer_impl.dart';
import '../../../../../common/state_renderer/state_renderer.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput{

  final _homeObjectStreamController= BehaviorSubject<HomeData>();


  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);


  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose(){
    _homeObjectStreamController.close();
    super.dispose();
  }

  // Inputs
  @override
  Sink get inputHomeObject => _homeObjectStreamController.sink;

  _getHomeData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
    (failure) {
    // left
      inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
    },
    (homeObject) {
    inputState.add(ContentState());
    inputHomeObject.add(homeObject.data);
    });
  }

  // Outputs

  @override
  Stream<HomeData> get outputHomeObject => _homeObjectStreamController.stream.map((data) => data);

}

abstract class HomeViewModelInput{
  Sink get inputHomeObject;
}

abstract class HomeViewModelOutput{
  Stream<HomeData> get outputHomeObject;
}