import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';

class SearchPage extends StatefulWidget{
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: AppStrings.search.tr(),
              prefixIcon: Icon(Icons.search,color: ColorManager.primary,),
            ),
          ),
        ],
      ),
    );
  }
}