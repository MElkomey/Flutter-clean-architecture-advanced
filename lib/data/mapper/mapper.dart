import 'package:flutter_advanced/app/extentions.dart';
import 'package:flutter_advanced/data/response/responses.dart';

import 'package:flutter_advanced/domain/model/models.dart';
import 'package:flutter_advanced/app/constants.dart';

extension CustomerResponseMapper on CustomerResponse? {
  //map the nullable response in data layer to non null data in domain layer

  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  //map the nullable response in data layer to non null data in domain layer

  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  //map the nullable response in data layer to non null data in domain layer
  Authentication toDomain(){
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }

}

