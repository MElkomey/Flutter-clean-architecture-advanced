import 'package:flutter_advanced/data/response/responses.dart';

///onboarding models
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject,this.numOfSlides,this.currentIndex);
}

///login models
class Customer{
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id,this.name,this.numOfNotifications);
}

class Contacts{

  String phone;
  String email;
  String link;

  Contacts(this.phone,this.email,this.link);
}

class Authentication{
  Customer? customer;/// any type none primitive must be nullable to avoid problems of initialization in mapping funcs
  Contacts? contacts;/// any type none primitive must be nullable to avoid problems of initialization in mapping funcs

  Authentication(this.customer,this.contacts);
}