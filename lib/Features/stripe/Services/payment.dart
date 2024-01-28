class PaymentIntentModel {
  int? status;
  IntentData? data;

  PaymentIntentModel({this.status, this.data});

  PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new IntentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class IntentData {
  String? paymentIntent;

  IntentData({this.paymentIntent});

  IntentData.fromJson(Map<String, dynamic> json) {
    paymentIntent = json['paymentIntent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentIntent'] = this.paymentIntent;
    return data;
  }
}