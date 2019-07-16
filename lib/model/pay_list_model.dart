class PayListModel {
  PayListModel({
    this.type,
    this.doorNo,
    this.unit,
    this.amount,
    this.date,
    this.info
}){}

  final String type;
  final String doorNo;
  final String unit;
  final String amount;
  final String date;
  final String info;
}

final List<PayListModel> payList  = [
  PayListModel(
    type: '水费',
    doorNo: '14******425',
    unit: '金华市自来水公司',
    amount: '56.34',
    date: '2019-06-06 12:23:46',
    info: '缴费成功',
  ),
  PayListModel(
    type: '电费',
    doorNo: '14******425',
    unit: '国网浙江省电力公司',
    amount: '260.53',
    date: '2019-06-06 12:24:22',
    info: '缴费成功',
  ),
  PayListModel(
    type: '燃气费',
    doorNo: '14******425',
    unit: '金华市燃气集团股份有限公司',
    amount: '12.23',
    date: '2019-06-06 12:26:12',
    info: '缴费成功',
  ),
];