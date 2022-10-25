import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_remderer_impl.dart';
import '../../resource/assets_manager.dart';
import '../../resource/color_manager.dart';
import '../../resource/string_manager.dart';
import '../../resource/values_Manager.dart';

class ForgetPasswordView extends StatefulWidget {
  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _emailController=TextEditingController();
  final ForgetPasswordViewModel _viewModel = instance<ForgetPasswordViewModel>();



  _bind(){
    _viewModel.start();
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
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
            return  snapshot.data?.getContentWidget(context,_getContentWidget(),(){_viewModel.forgetPassword();}) ?? _getContentWidget();
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
                  stream: _viewModel.outISEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppStrings.email.tr(),
                        errorText: (snapshot.data ?? true) ? null : AppStrings.emailError.tr(),
                      ),
                    );
                  }
              ),
              const SizedBox(height: AppSize.s45,),
              StreamBuilder<bool>(
                  stream: _viewModel.outISEmailValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false) ?
                            (){_viewModel.forgetPassword();}:null,
                        child: Text(
                          AppStrings.resetPassword.tr(),
                        ),
                      ),
                    );
                  }
              ),
              const SizedBox(height: AppSize.s20,),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      AppStrings.resend.tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
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