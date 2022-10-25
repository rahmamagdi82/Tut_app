import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';
import 'package:tut_app/presentation/resource/constants_manager.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';
import 'package:tut_app/presentation/resource/values_Manager.dart';

import '../../../app/di.dart';
import '../../resource/routes_manager.dart';

class OnBoardingView extends StatefulWidget {
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final PageController _pageViewController = PageController();
  final OnBoardingViewModel _viewModel=OnBoardingViewModel();
  final AppPrefs _appPrefs = instance<AppPrefs>();
  _bind(){
    _viewModel.start();
    _appPrefs.putData(key: PREFS_KEY_ONBOARDING, value: true);
  }

  @override
  void initState(){
    _bind();
    super.initState();
  }

  Widget _getContentWidget(SliderViewObject? data) {
    if(data == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }else {
      return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorManager.white,
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: ColorManager.primary,
        //   statusBarBrightness: Brightness.dark,
        // ),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return builderItem(data.sliderObject);
        },
        controller: _pageViewController,
        itemCount: data.numOfSliders,
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip.tr(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Container(
              height: AppSize.s45,
              color: ColorManager.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _pageViewController.animateToPage(
                        _viewModel.goPrevious(),
                        duration: const Duration(
                            milliseconds: ConstantsManager.pageViewDelay),
                        curve: Curves.bounceInOut,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorManager.white,
                    ),
                  ),
                  StepsIndicator(
                    selectedStep: data.currentIndex,
                    nbSteps: data.numOfSliders,
                    selectedStepColorOut: ColorManager.white,
                    selectedStepColorIn: ColorManager.primary,
                    unselectedStepColorOut: ColorManager.white,
                    unselectedStepColorIn: ColorManager.white,
                    doneStepColor: ColorManager.white,
                    undoneLineColor: ColorManager.primary,
                    doneLineColor: ColorManager.primary,
                    lineLength: AppSize.s20,
                    selectedStepBorderSize: AppSize.s1, // Custom Widget
                  ),
                  IconButton(
                    onPressed: () {
                      _pageViewController.animateToPage(
                        _viewModel.goNext(),
                        duration: const Duration(
                            milliseconds: ConstantsManager.pageViewDelay),
                        curve: Curves.bounceInOut,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context,snapshot){
        return _getContentWidget(snapshot.data);
      },
    );
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }

  Widget builderItem(SliderObject sliderObject){
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        children: [
          Text(
            sliderObject.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSize.s8,),
          Text(
            sliderObject.subTitle,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSize.s70,),
          SvgPicture.asset(sliderObject.image),
        ],
      ),
    );
  }
}