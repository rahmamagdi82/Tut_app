import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_remderer_impl.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';
import 'package:tut_app/presentation/resource/values_Manager.dart';
import 'package:tut_app/presentation/store_details/viewmodel/store_details_viewmpdel.dart';

import '../../../app/di.dart';

class StoreDetailsView extends StatefulWidget{
  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {

  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.storeDetails.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getContentWidget(context,_getContentWidget(),(){_viewModel.start();}) ?? _getContentWidget();
        },
      ),
      //_getContentWidget(),
    );
  }

  Widget _getContentWidget(){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s16),
        child: StreamBuilder<StoreObject>(
          stream: _viewModel.outputStoreDetails,
          builder: (context, snapshot) {
            if(snapshot.data != null) {
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: AppSize.s180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(AppSize.s8),topLeft: Radius.circular(AppSize.s8)),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(fit: BoxFit.cover,"${snapshot.data!.image}"),
                ),
                const SizedBox(height: AppSize.s16,),
                _getSectionWidget(AppStrings.details.tr()),
                _getParagraphWidget("${snapshot.data!.details}"),
                _getSectionWidget(AppStrings.services.tr()),
                _getParagraphWidget("${snapshot.data!.services} "),
                _getSectionWidget(AppStrings.aboutStores.tr()),
                _getParagraphWidget("${snapshot.data!.about}"),
              ],
            );
            }else
              {
                return Container();
              }
          }
        ),
      ),
    );
  }

  Widget _getSectionWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s8,top: AppSize.s20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _getParagraphWidget(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }
}