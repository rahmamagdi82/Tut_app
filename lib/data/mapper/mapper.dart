import 'package:tut_app/app/constants.dart';
import 'package:tut_app/app/extentions.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/model/models.dart';

extension CutomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotification.orZero() ?? Constants.zero
    );
  }
}

extension ContactResponseMapper on ContactsResponse?{
  Contacts toDomain(){
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(
       this?.customer.toDomain(),
      this?.contacts.toDomain()
    );
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse?{
  String toDomain(){
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension ServicesResponseMapper on ServicesResponse?{
  Services toDomain(){
    return Services(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty
    );
  }
}

extension BannersResponseMapper on BannersResponse?{
  Banners toDomain(){
    return Banners(
        this?.id.orZero() ?? Constants.zero,
        this?.link.orEmpty() ?? Constants.empty,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty
    );
  }
}

extension StoresResponseMapper on StoresResponse?{
  Stores toDomain(){
    return Stores(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty
    );
  }
}

extension HomeDataResponseMapper on HomeResponse?{
  HomeObject toDomain(){
    List<Services> services=(this?.data?.services?.map((servicesResponse) => servicesResponse.toDomain()) ??
        const Iterable.empty()).
    cast<Services>().toList();

    List<Banners> banners=(this?.data?.banners?.map((bannersResponse) => bannersResponse.toDomain()) ??
        const Iterable.empty()).
    cast<Banners>().toList();

    List<Stores> stores=(this?.data?.stores?.map((storesResponse) => storesResponse.toDomain()) ??
        const Iterable.empty()).
    cast<Stores>().toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse?{
  StoreObject toDomain(){
    return StoreObject(
        this?.image.orEmpty() ?? Constants.empty,
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
      this?.details.orEmpty() ?? Constants.empty,
      this?.services.orEmpty() ?? Constants.empty,
      this?.about.orEmpty() ?? Constants.empty
    );
  }
}

extension NotificationDataResponseMapper on NotificationDataResponse?{
  NotificationData toDomain(){
    return NotificationData(
        this?.id.orZero() ?? Constants.zero,
        this?.sender.orEmpty() ?? Constants.empty,
        this?.message.orEmpty() ?? Constants.empty,
    );
  }
}

extension NotificationResponseMapper on NotificationsResponse?{
  NotificationModel toDomain(){
    List<NotificationData> notification=(this?.notifications.map((notificationDataResponse) => notificationDataResponse.toDomain()) ??
        const Iterable.empty()).
    cast<NotificationData>().toList();
    var data = NotificationModel(notification);
    return data;
  }
}