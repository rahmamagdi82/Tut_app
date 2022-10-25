
// onBoarding models

class SliderObject{
  String title;
  String subTitle;
  String image;
  SliderObject(this.title,this.subTitle,this.image);
}

// from viewModel to view
class SliderViewObject{
  SliderObject sliderObject;
  int numOfSliders;
  int currentIndex;
  SliderViewObject(this.sliderObject,this.numOfSliders,this.currentIndex);
}

// login models

class Customer{
  String id;
  String name;
  int numOfNotification;

  Customer(this.id,this.name,this.numOfNotification);
}

class Contacts{
  String phone;
  String email;
  String link;

  Contacts(this.phone,this.email,this.link);
}

class Authentication{
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer,this.contacts);
}

// Home model

class Services{
  int? id;
  String? title;
  String? image;

  Services(this.id,this.title,this.image);
}

class Banners{
  int? id;
  String? link;
  String? title;
  String? image;

  Banners(this.id,this.link,this.title,this.image);
}

class Stores{
  int? id;
  String? title;
  String? image;

  Stores(this.id,this.title,this.image);
}

class HomeData{
  List<Services> services;
  List<Banners> banners;
  List<Stores> stores;

  HomeData(this.services,this.banners,this.stores);
}

class HomeObject{
  HomeData data;

  HomeObject(this.data);
}

class StoreObject{
  int? id;
  String? title;
  String? image;
  String? details;
  String? about;
  String? services;

  StoreObject(this.image,this.id,this.title,this.details,this.services,this.about);
}

class NotificationData{
  int? id;
  String? sender;
  String? message;
  String? image;

  NotificationData(this.id,this.sender,this.message,this.image);
}

class NotificationModel{
  List<NotificationData> notificationsList;

  NotificationModel(this.notificationsList);
}