import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/common/state_renderer/state_remderer_impl.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';
import 'package:tut_app/presentation/resource/values_Manager.dart';

import '../../../../../../app/di.dart';
import '../../../../../../domain/model/models.dart';
import '../../../../../resource/color_manager.dart';
import '../../../../../resource/routes_manager.dart';
import '../viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeViewModel _viewModel = instance<HomeViewModel>();

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
        return snapshot.data?.getContentWidget(context,_getContentWidget(),(){_viewModel.start();}) ?? _getContentWidget();
      },
    );
  }



  Widget _getContentWidget() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: StreamBuilder<HomeData>(
          stream: _viewModel.outputHomeObject,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getBannersCarousel(snapshot.data?.banners),
                _getSectionWidget(AppStrings.services.tr()),
                _getServicesWidget(snapshot.data?.services),
                _getSectionWidget(AppStrings.stores.tr()),
                _getStoresWidget(snapshot.data?.stores),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _getBannersCarousel(List<Banners>? banners) {
    if(banners != null){
      return CarouselSlider(
        items: banners.map((banner) =>
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                  "${banner.image}",
                fit: BoxFit.cover,
              ),
            ),
        ).toList(),
        options: CarouselOptions(
          autoPlay: true,
          height: AppSize.s180,
          enableInfiniteScroll: true,
          enlargeCenterPage: true

        ),
      );
    }else {
      return Container();
    }
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

 Widget _getServicesWidget(List<Services>? services) {
    if(services != null) {
      return SizedBox(
        height: 145.0,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return _getOneServiceWidget(services[index]);
          },
          separatorBuilder: (context,index)=>const SizedBox(width: AppSize.s14,),
          itemCount: services.length,
    ),
      );
    }else {
      return Container();
    }
 }

 Widget _getOneServiceWidget(Services item){
     return Card(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(AppSize.s12)
       ),
       clipBehavior: Clip.antiAliasWithSaveLayer,
       elevation: AppSize.s1_5,
       child: Column(
         children: [
           Image.network(
             "${item.image}",
             height: 100.0,
             fit: BoxFit.cover,
           ),
           const SizedBox(height: AppSize.s12,),
           Text(
             "${item.title}",
             style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.grey1),
           ),
         ],
       ),
     );
  }

  Widget _getStoresWidget(List<Stores>? stores) {
    if (stores != null) {
      return Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: AppSize.s8,
            mainAxisSpacing: AppSize.s8,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(stores.length, (index) {
              return InkWell(
                onTap: () {
                  // navigate to store details screen
                  Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                },
                child: Card(
                  elevation: AppSize.s4,
                  child: Image.network(
                    "${stores[index].image}",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }
}

