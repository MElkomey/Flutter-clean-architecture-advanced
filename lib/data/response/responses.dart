
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';


/// login api responses
@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}


@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id,this.name,this.numOfNotifications);
  ///from json
  factory CustomerResponse.fromJson(Map<String,dynamic> json)=>_$CustomerResponseFromJson(json);
  ///to json
  Map<String, dynamic> toJson()=>_$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone,this.email,this.link);

  ///from json
  factory ContactsResponse.fromJson(Map<String,dynamic> json)=>_$ContactsResponseFromJson(json);
  ///to json
  Map<String, dynamic> toJson()=>_$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer,this.contacts);

  ///jsonSerialization is responsible to make this two functions
  /// go to terminal -> flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
  /// there will be an auto generated file named  part responses.g.dart must put in top of file
  ///then clear then run the command again

  ///from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=>_$AuthenticationResponseFromJson(json);
  ///to json
  Map<String, dynamic> toJson()=>_$AuthenticationResponseToJson(this);
}

/// /////////////////////////////////////////////////////////////////////////////