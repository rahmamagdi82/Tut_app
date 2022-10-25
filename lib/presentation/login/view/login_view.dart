import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_remderer_impl.dart';
import 'package:tut_app/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:tut_app/presentation/resource/assets_manager.dart';
import 'package:tut_app/presentation/resource/color_manager.dart';
import 'package:tut_app/presentation/resource/string_manager.dart';

import '../../../app/app_prefs.dart';
import '../../resource/routes_manager.dart';
import '../../resource/values_Manager.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _keyForm = GlobalKey<FormState>();

  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final AppPrefs _appPrefs = instance<AppPrefs>();

  _bind(){
    _viewModel.start();
    _userNameController.addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isLoggedIn) {
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
          return  snapshot.data?.getContentWidget(context,_getContentWidget(),(){_viewModel.login();}) ?? _getContentWidget();
    }
        ),
    );
  }

  Widget _getContentWidget(){
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
                StreamBuilder<bool>(
                  stream: _viewModel.outISUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.userName.tr(),
                        errorText: (snapshot.data ?? true) ? null : AppStrings.userNameError.tr(),
                      ),
                    );
                  }
                ),
                const SizedBox(height: AppSize.s20,),
                StreamBuilder<bool>(
                  stream: _viewModel.outISPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: AppStrings.password.tr(),
                        errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError.tr(),
                      ),
                    );
                  }
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
                              (){_viewModel.login();} :
                          null,
                          child: Text(
                            AppStrings.login.tr(),
                          ),
                      ),
                    );
                  }
                ),
                const SizedBox(height: AppSize.s20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                        },
                      child: Text(
                        AppStrings.forgetPassword.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: Text(
                        AppStrings.registerText.tr(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  }

  @override
  void dispose(){
    _viewModel.dispose();
    super.dispose();
  }
}