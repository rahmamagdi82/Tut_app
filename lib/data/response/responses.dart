
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse{
  @JsonKey(name:"status") // real name in api
  int? status;// use in my project
  @JsonKey(name:"message")
  String? message;
}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name:"id")
  String? id;
  @JsonKey(name:"name")
  String? name;
  @JsonKey(name:"numOfNotification")
  int? numOfNotification;

  CustomerResponse(this.id,this.name,this.numOfNotification);

  factory CustomerResponse.fromJson(Map<String,dynamic> json)=> _$CustomerResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name:"phone")
  String? phone;
  @JsonKey(name:"email")
  String? email;
  @JsonKey(name:"link")
  String? link;

  ContactsResponse(this.phone,this.email,this.link);

  factory ContactsResponse.fromJson(Map<String,dynamic> json)=> _$ContactsResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name:"customer")
  CustomerResponse? customer;
  @JsonKey(name:"contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer,this.contacts);

  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=> _$AuthenticationResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse{
  @JsonKey(name:"support")
  String? support;

  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String,dynamic> json)=> _$ForgetPasswordResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$ForgetPasswordResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name:"data")
  DataResponse? data;

  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String,dynamic> json)=> _$HomeResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$HomeResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name:"services")
  List<ServicesResponse>? services;
  @JsonKey(name:"banners")
  List<BannersResponse>? banners;
  @JsonKey(name:"stores")
  List<StoresResponse>? stores;

  DataResponse(this.services,this.banners,this.stores);

  factory DataResponse.fromJson(Map<String,dynamic> json)=> _$DataResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$DataResponseToJson(this);
}

@JsonSerializable()
class ServicesResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;

  ServicesResponse(this.id,this.title,this.image);

  factory ServicesResponse.fromJson(Map<String,dynamic> json)=> _$ServicesResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$ServicesResponseToJson(this);
}

@JsonSerializable()
class BannersResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"link")
  String? link;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;

  BannersResponse(this.id,this.link,this.title,this.image);

  factory BannersResponse.fromJson(Map<String,dynamic> json)=> _$BannersResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$BannersResponseToJson(this);
}

@JsonSerializable()
class StoresResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;

  StoresResponse(this.id,this.title,this.image);

  factory StoresResponse.fromJson(Map<String,dynamic> json)=> _$StoresResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$StoresResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"image")
  String? image;
  @JsonKey(name:"details")
  String? details;
  @JsonKey(name:"about")
  String? about;
  @JsonKey(name:"services")
  String? services;

  StoreDetailsResponse(this.image,this.id,this.title,this.details,this.services,this.about);

  factory StoreDetailsResponse.fromJson(Map<String,dynamic> json)=> _$StoreDetailsResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$StoreDetailsResponseToJson(this);
}

@JsonSerializable()
class NotificationsResponse extends BaseResponse{
  @JsonKey(name:"notifications")
  List<NotificationDataResponse> notifications;

  NotificationsResponse(this.notifications);

  factory NotificationsResponse.fromJson(Map<String,dynamic> json)=> _$NotificationsResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationDataResponse{
  @JsonKey(name:"id")
  int? id;
  @JsonKey(name:"sender")
  String? sender;
  @JsonKey(name:"message")
  String? message;

  NotificationDataResponse(this.id,this.sender,this.message);

  factory NotificationDataResponse.fromJson(Map<String,dynamic> json)=> _$NotificationDataResponseFromJson(json);

  Map<String,dynamic> toJason()=> _$NotificationDataResponseToJson(this);
}