import 'package:tut_app/data/network/error_handler.dart';

import '../response/responses.dart';


const CACHE_HOME_KET = "CACHE_HOME_KET";
const CACHE_STORE_KET = "CACHE_STORE_KET";
const CACHE_NOTIFICATION_KET = "CACHE_NOTIFICATION_KET";

const CACHE_HOME_INTERVAL = 60*1000;


abstract class LocalDataSource{

  Future<HomeResponse> home();
  Future<StoreDetailsResponse> storeDetails();
  Future<NotificationsResponse> notification();


  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<void> saveStoreToCache(StoreDetailsResponse storeDetailsResponse);
  Future<void> saveNotificationsToCache(NotificationsResponse notificationsResponse);


  void clearCache();
  void removeFromCache(String key);

}

class LocalDataSourceImpl implements LocalDataSource{

  Map<String,CacheItem> cacheMap=Map();

  @override
  Future<HomeResponse> home() async{
    CacheItem? cacheItem = cacheMap[CACHE_HOME_KET];
   if(cacheItem != null && cacheItem.isValid(CACHE_HOME_INTERVAL)){
     // return response from cache
     return cacheItem.data;
   }else
     {
       // return an error that cache is not there or its not valid
       throw ErrorHandler.handle(DataSource.CACHE_ERROR);
     }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KET]=CacheItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> storeDetails() async{
    CacheItem? cacheItem = cacheMap[CACHE_STORE_KET];
    if(cacheItem != null && cacheItem.isValid(CACHE_HOME_INTERVAL)){
      // return response from cache
      return cacheItem.data;
    }else
    {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreToCache(StoreDetailsResponse storeDetailsResponse) async {
    cacheMap[CACHE_STORE_KET]=CacheItem(storeDetailsResponse);
  }

  @override
  Future<NotificationsResponse> notification() async{
    CacheItem? cacheItem = cacheMap[CACHE_NOTIFICATION_KET];
    if(cacheItem != null && cacheItem.isValid(CACHE_HOME_INTERVAL)){
      // return response from cache
      return cacheItem.data;
    }else
    {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveNotificationsToCache(NotificationsResponse notificationsResponse) async{
    cacheMap[CACHE_NOTIFICATION_KET]=CacheItem(notificationsResponse);
  }
}

class CacheItem{
  dynamic data;
  int time = DateTime.now().millisecondsSinceEpoch;

  CacheItem(this.data);
}

extension CacheItemExtension on CacheItem{
  bool isValid(int expirationTimeInMillis){
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid= currentTimeInMillis - time <= expirationTimeInMillis ;
    return isValid;
  }
}