
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/forget_password/viewmodel/forget_password_viewmodel.dart';
import 'package:tut_app/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:tut_app/presentation/register/viewmodel/register_viewmodel.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/forget_password_usecase.dart';
import '../domain/usecase/home_usecase.dart';
import '../domain/usecase/notifications_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../presentation/main/view/pages/home/viewmodel/home_viewmodel.dart';
import '../presentation/main/view/pages/notification/viewmodel/notification_viewmodel.dart';
import '../presentation/store_details/viewmodel/store_details_viewmpdel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async{

  // shared preferences instance
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // app prefs instance
  instance.registerLazySingleton<AppPrefs>(() => AppPrefs(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp(instance<AppServicesClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(), instance(),instance()));
}

 initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>())
    {
      instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
      instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
    }
}

initForgetPasswordModule(){
  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>())
  {
    instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
  }
}

initRegisterModule(){
  if(!GetIt.I.isRegistered<RegisterUseCase>())
  {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());

  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() =>
        HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() =>
        HomeViewModel(instance()));
  }
}

  initStoreDetailsModule() {
    if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
      instance.registerFactory<StoreDetailsUseCase>(() =>
          StoreDetailsUseCase(instance()));
      instance.registerFactory<StoreDetailsViewModel>(() =>
          StoreDetailsViewModel(instance()));
    }
  }

initNotificationsModule() {
  if (!GetIt.I.isRegistered<NotificationUseCase>()) {
    instance.registerFactory<NotificationUseCase>(() =>
        NotificationUseCase(instance()));
    instance.registerFactory<NotificationViewModel>(() =>
        NotificationViewModel(instance()));
  }
}