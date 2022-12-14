import 'package:flutter/material.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_remderer_impl.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';
import 'package:tut_app/presentation/resource/values_Manager.dart';

import '../../../../../../app/di.dart';
import '../viewmodel/notification_viewmodel.dart';

class NotificationPage extends StatefulWidget{
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final NotificationViewModel _viewModel = instance<NotificationViewModel>();

  _bind(){
    _viewModel.start();
  }

  @override
  void initState(){
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getContentWidget(context,_getWidgetContent(),(){_viewModel.start();}) ?? _getWidgetContent();
        }
    );
  }

  Widget _getWidgetContent() {
    return StreamBuilder<NotificationModel>(
      stream: _viewModel.outputNotifications,
      builder: (context,snapshot){
        if(snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: ListView.separated(
              itemBuilder: (context,index)=> _getNotificationItem(snapshot.data!.notificationsList[index]),
              separatorBuilder: (context,index)=>Container(
                height: AppSize.s1,
                width: double.infinity,
                color: ColorManager.lightGrey,
              ),
              itemCount: snapshot.data!.notificationsList.length,
        ),
          );
        }else
          {
            return Container();
          }
      },
    );
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }

  _getNotificationItem(NotificationData? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: AppSize.s30,
            backgroundImage: NetworkImage("${data!.image}"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
              child: RichText(
                text: TextSpan(
                  text: '${data.sender} ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.grey1),
                  children: [
                    TextSpan(
                     text: "${data.message}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.grey2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Text(
          //   "${data.sender}",
          //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.grey1
          //   ),
          // ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: AppSize.s4),
          //     child: Text(
          //       "${data.message}",
          //       style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.grey2),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}