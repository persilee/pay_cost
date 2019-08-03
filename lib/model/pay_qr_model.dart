
class QrModel {
  String respMessage;
  String orderNo;
  String merNo;
  String merOrderNo;
  String signature;
  String customerId;
  String cardNo;
  String respCode;
  String md5Info;

  QrModel(
      {this.respMessage,
        this.orderNo,
        this.merNo,
        this.merOrderNo,
        this.signature,
        this.customerId,
        this.cardNo,
        this.respCode,
        this.md5Info});

  QrModel.fromJson(Map<String, dynamic> json) {
    respMessage = json['respMessage'];
    orderNo = json['orderNo'];
    merNo = json['merNo'];
    merOrderNo = json['merOrderNo'];
    signature = json['signature'];
    customerId = json['customerId'];
    cardNo = json['cardNo'];
    respCode = json['respCode'];
    md5Info = json['Md5Info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['respMessage'] = this.respMessage;
    data['orderNo'] = this.orderNo;
    data['merNo'] = this.merNo;
    data['merOrderNo'] = this.merOrderNo;
    data['signature'] = this.signature;
    data['customerId'] = this.customerId;
    data['cardNo'] = this.cardNo;
    data['respCode'] = this.respCode;
    data['Md5Info'] = this.md5Info;
    return data;
  }
}