import 'package:flutter/material.dart';

class AgreementPage extends StatefulWidget {
  @override
  _AgreementPageState createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '用户协议', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        elevation: 0,
        iconTheme: IconThemeData(size: 16, color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 6)),
                Center(
                  child: Text('巨鹏燃气APP用户隐私协议', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87,),),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 2)),
                Text('    本软件尊重并保护所有使用服务用户的个人隐私权。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('    为了给您提供更准确、更有个性化的服务，本软件会按照本隐私权政策的规定使用和披露您的个人信息。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('    但本软件将以高度的勤勉、审慎义务对待这些信息。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('    除本隐私权政策另有规定外，在未征得您事先许可的情况下，本软件不会将这些信息对外披露或向第三方提供。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('    本软件会不时更新本隐私权政策。您在同意本软件服务使用协议之时，即视为您已经同意本隐私权政策全部内容。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('    本隐私权政策属于本软件服务使用协议不可分割的一部分。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('1.适用范围', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  a)在您使用本软件网络服务，本软件自动接收并记录的您的手机上的信息，包括但不限于您的健康数据、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('2.信息的使用', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  a)在获得您的数据之后，本软件会将其上传至服务器，以生成您的排行榜数据，以便您能够更好地使用服务。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('3.信息披露', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  a)本软件不会将您的信息披露给不受信任的第三方。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  b)根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  c)如您出现违反中国有关法律、法规或者相关规则的情况，需要向第三方披露；', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('4.信息存储和交换', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  本软件收集的有关您的信息和资料将保存在本软件及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或本软件收集信息和资料所在地的境外并在境外被访问、存储和展示。', style: TextStyle(fontSize: 16, color: Colors.black54),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('5.信息安全', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text('  a)在使用本软件网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，请您立即联络本软件客服，以便本软件采取相应措施。', style: TextStyle(fontSize: 16, color: Colors.black54),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
