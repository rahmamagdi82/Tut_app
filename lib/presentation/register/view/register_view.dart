import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/app/constants.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_remderer_impl.dart';
import '../../resource/assets_manager.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/routes_manager.dart';
import '../../resource/string_manager.dart';
import '../../resource/style_manager.dart';
import '../../resource/values_Manager.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget{
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _userNameController=TextEditingController();
  final TextEditingController _mobileNumberController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPrefs _appPrefs = instance<AppPrefs>();

  _bind(){
    _viewModel.start();
    _userNameController.addListener(() => _viewModel.setUserName(_userNameController.text));
    _mobileNumberController.addListener(() => _viewModel.setMobilePhone(_mobileNumberController.text));
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserRegisterSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPrefs.putData(key: PREFS_KEY_LOGIN, value: true);
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState(){
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body:  StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context,snapshot){
            return  snapshot.data?.getContentWidget(context,_getContentWidget(context),(){_viewModel.register();}) ?? _getContentWidget(context);
          }
      ),
    );
  }

  Widget _getContentWidget(context){
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top:AppPadding.p80),
                child: Center(child: Image(image: AssetImage(AssetsManager.splashLogo))),
              ),
              const SizedBox(height: AppSize.s45,),
                  StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          controller: _userNameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: AppStrings.userName.tr(),
                            errorText: snapshot.data,
                          ),
                        );
                      }
                  ),
              const SizedBox(height: AppSize.s20,),
              Row(
                children: [
                  Expanded(
                    child: CountryCodePicker(
                      onChanged: (countryCode){
                        _viewModel.setCountryMobileCode(countryCode.dialCode ?? Constants.empty);
                      },
                    initialSelection: "eg",
                    hideMainText: true,
                  ),
                  ),
                  Expanded(
                    flex: 3,
                    child: StreamBuilder<String?>(
                       stream: _viewModel.outputErrorMobilePhone,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _mobileNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: AppStrings.phone.tr(),
                              errorText: snapshot.data,
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s20,),
              StreamBuilder<String?>(
                 stream: _viewModel.outputErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.email.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  }
              ),
              const SizedBox(height: AppSize.s20,),
              StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: AppStrings.password.tr(),
                        errorText: snapshot.data,
                      ),
                    );
                  }
              ),
              const SizedBox(height: AppSize.s20,),
              Container(
                width: double.infinity,
                height: AppSize.s45,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                  border: Border.all(
                      color: ColorManager.grey,
                      width: AppSize.s1_5,
                  ),
                ),
                child: InkWell(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            AppStrings.profilePicture.tr(),
                            style: getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
                          ),
                        ),
                        Flexible(
                          child: StreamBuilder<File>(
                            stream: _viewModel.outISProfilePictureValid,
                            builder: (context,snapshot){
                              return _imagePicketByUser(snapshot.data);
                            },
                        ),
                        ),
                        Flexible(
                          child: SvgPicture.asset(
                            AssetsManager.camera,
                            color: ColorManager.grey,
                            height: AppSize.s20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s45,),
              StreamBuilder<bool>(
                  stream: _viewModel.outISAllValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false) ?
                             (){_viewModel.register();} :
                        null,
                        child: Text(
                          AppStrings.register.tr(),
                        ),
                      ),
                    );
                  }
              ),
              const SizedBox(height: AppSize.s20,),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppStrings.loginText.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePicketByUser(File? image) {
    if(image != null && image.path.isNotEmpty){
      // return image
      return Image.file(image);
    }else
      {
        return Container();
      }
  }

  void _showPicker(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context){
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera),
              title: Text(AppStrings.photoGallery.tr()),
              onTap: (){
                _imageFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(AppStrings.photoCamera.tr()),
              onTap: (){
                _imageFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      },
    );

  }

  Future<void> _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
      _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Future<void> _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
      _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }
}