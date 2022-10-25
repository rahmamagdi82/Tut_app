import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';
import 'package:tut_app/presentation/resource/font_manager.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';
import 'package:tut_app/presentation/resource/values_Manager.dart';

import '../../resource/assets_manager.dart';
import '../../resource/style_manager.dart';

enum StateRendererType{
  // popup state
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  // full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // general
  contentState,
}

class StateRenderer extends StatelessWidget{

  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    required this.stateRendererType,
    this.message=AppStrings.loading,
    this.title="",
    required this.retryActionFunction,
});

  @override
  Widget build(BuildContext context) {
    return _getWidget(context);
  }

  Widget _getWidget(context){
    switch(stateRendererType){

      case StateRendererType.popupLoadingState:
        return _getPopupDialog(
            context,[
          _getAnimatedImage(JsonManager.loading),
        ]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(
            context,
            [
              _getAnimatedImage(JsonManager.error),
              _getMessage(message),
              _getRetryButton(AppStrings.ok.tr(), context),
            ]
        );
      case StateRendererType.popupSuccessState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonManager.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(JsonManager.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonManager.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain.tr(),context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage(JsonManager.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();

      default: return Container();

    }
  }

  Widget _getItemsColumn(List<Widget> children){
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
       children: children,

    );
  }

  Widget _getAnimatedImage(String animationName){
    return Center(
      child: SizedBox(
        height: AppSize.s120,
        width: AppSize.s120,
        child:Lottie.asset(animationName),
      ),
    );
  }

  Widget _getMessage(String message){
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p20,right: AppPadding.p20,top: AppPadding.p20),
      child: Text(
        message,
        style: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s18,
        ),
      ),
    );
  }

  Widget _getRetryButton(String title,context){
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SizedBox(
        width: double.infinity,
        height: AppSize.s40,
        child: ElevatedButton(
          onPressed: (){
            if(stateRendererType == StateRendererType.fullScreenErrorState){
              retryActionFunction.call();
            }else
              {
                Navigator.of(context).pop();
              }
          } ,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }

  Widget _getPopupDialog(context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(
            color: Colors.black26,
          )],
        ),
        child: _getDialogContent(context,children),
      ),
    );
  }

  Widget _getDialogContent(context,List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}