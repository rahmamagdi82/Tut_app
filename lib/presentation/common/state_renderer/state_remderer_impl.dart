import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading state
class LoadingState extends FlowState{
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, this.message=AppStrings.loading});

  @override
  String getMessage() => message.tr();

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state
class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState{
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty state
class EmptyState extends FlowState{
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.fullScreenEmptyState;
}

// success state
class SuccessState extends FlowState{
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
}

extension FlowStateExtention on FlowState{
  Widget getContentWidget(context,Widget contentWidget,Function retryActionFunction){
    switch(runtimeType){

      case LoadingState:
        {
          if(getStateRendererType() == StateRendererType.popupLoadingState)
            {
              // show pop up
              showPopup(context,getStateRendererType(),getMessage());
              // show content ui screen
              return contentWidget;
            }else
              {
                // full screen
                return StateRenderer(stateRendererType: getStateRendererType(),message: getMessage(), retryActionFunction: retryActionFunction);
              }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if(getStateRendererType() == StateRendererType.popupErrorState)
          {
            // show pop up
            showPopup(context,getStateRendererType(),getMessage());
            // show content ui screen
            return contentWidget;
          }else
          {
            // full screen
            return StateRenderer(stateRendererType: getStateRendererType(),message: getMessage(), retryActionFunction: retryActionFunction);
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
          // show pop up
            showPopup(context,getStateRendererType(),getMessage(),title:AppStrings.success.tr());
            // show content ui screen
            return contentWidget;

        }

      case EmptyState:
        {
          return StateRenderer(stateRendererType: getStateRendererType(), message: getMessage(),retryActionFunction: (){});

        }
      case ContentState:
        {
          dismissDialog(context);
          return contentWidget;
        }
        default:
        {
          dismissDialog(context);
          return contentWidget;

        }
    }
  }

  _isCurrentDialogShow(context)=>ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(context){
    if(_isCurrentDialogShow(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  showPopup(context,StateRendererType stateRendererType ,String message,
      {String title=Constants.empty}){
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        builder: (BuildContext context) {
          return StateRenderer(stateRendererType: stateRendererType, retryActionFunction: (){},message: message,title: title,);
        },
        context: context));
  }
}