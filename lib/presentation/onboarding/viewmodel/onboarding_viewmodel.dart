import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/resource/assets_manager.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs{

  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex=0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list=getSliders();
    _postDataToView();
  }


  @override
  int goNext() {
    _currentIndex++;
    if(_currentIndex > _list.length)
        {
      _currentIndex=0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    _currentIndex--;
    if(_currentIndex < 0)
    {
      _currentIndex=_list.length;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex=index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  // onBoarding private function
List<SliderObject> getSliders()=>[
  SliderObject(AppStrings.onBoardingTitle1.tr(),AppStrings.onBoardingSubTitle1.tr(),AssetsManager.onBoardingLogo1),
  SliderObject(AppStrings.onBoardingTitle2.tr(),AppStrings.onBoardingSubTitle2.tr(),AssetsManager.onBoardingLogo2),
  SliderObject(AppStrings.onBoardingTitle3.tr(),AppStrings.onBoardingSubTitle3.tr(),AssetsManager.onBoardingLogo3),
  SliderObject(AppStrings.onBoardingTitle4.tr(),AppStrings.onBoardingSubTitle4.tr(),AssetsManager.onBoardingLogo4),
  ];


}

// inputs means "orders"
abstract class OnBoardingViewModelInputs{
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

// stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs{
// stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}