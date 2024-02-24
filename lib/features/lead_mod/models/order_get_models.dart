import 'dart:convert';

class TherapyOrderRequest {
  String? id;
  String? requester;
  String? orderDate;
  String? phoneNo;
  String? address;
  String? startTime;
  String? endTime;
  String? howToKnow;
  String? userStatus;
  String? serviceType;

  TherapyOrderRequest(
      {this.id,
      this.requester,
      this.orderDate,
      this.phoneNo,
      this.address,
      this.startTime,
      this.endTime,
      this.howToKnow,
      this.userStatus,
      this.serviceType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requester': requester,
      'orderDate': orderDate,
      'phoneNo': phoneNo,
      'address': address,
      'startTime': startTime,
      'endTime': endTime,
      'howToKnow': howToKnow,
      'userStatus': userStatus,
      'serviceType': serviceType,
    };
  }

  factory TherapyOrderRequest.fromMap(Map<String, dynamic> map) {
    return TherapyOrderRequest(
      id: map['_id'],
      requester: map['requester'],
      orderDate: map['orderDate'],
      phoneNo: map['phoneNo'],
      address: map['address'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      howToKnow: map['howToKnow'],
      userStatus: map['userStatus'],
      serviceType: map['serviceType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TherapyOrderRequest.fromJson(String source) =>
      TherapyOrderRequest.fromMap(json.decode(source));
}
