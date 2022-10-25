import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../common/state_renderer/state_remderer_impl.dart';
import '../../common/state_renderer/state_renderer.dart';

class StoreDetailsViewModel extends BaseViewModel with StoreDetailsViewModelInput,StoreDetailsViewModelOutput{

  final _storeDetailsObjectStreamController= BehaviorSubject<StoreObject>();


  final StoreDetailsUseCase _storeDetailsUseCase;
  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoreData();
  }

  @override
  void dispose() {
    _storeDetailsObjectStreamController.close();
    super.dispose();
  }

//inputs

  @override
  Sink get inputStoreDetailsObject => _storeDetailsObjectStreamController.sink;

  _getStoreData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(Void)).fold(
            (failure) {
          // left
          inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
        },
            (storeObject) {
          inputState.add(ContentState());
          inputStoreDetailsObject.add(storeObject);
        });
  }

//outputs

  @override
  Stream<StoreObject> get outputStoreDetails => _storeDetailsObjectStreamController.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInput{
  Sink get inputStoreDetailsObject;
}

abstract class StoreDetailsViewModelOutput{
  Stream<StoreObject> get outputStoreDetails;
}