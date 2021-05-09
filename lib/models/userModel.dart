class UserModel {
  String id;
  String fName;
  String sName;
  DateTime bornDate;
  String email;
  String gender;
  String verifyCode;
  String isVerify;
  String loginAuthkey;
  int loginAuthKeyUpdate;
  int isProduces;

  UserModel._init({
    this.id,
    this.fName,
    this.sName,
    this.bornDate,
    this.email,
    this.gender,
    this.verifyCode,
    this.isVerify,
    this.loginAuthkey,
    this.loginAuthKeyUpdate,
    this.isProduces,
  });
  static UserModel _instance;
  static UserModel get instance => _instance ??= UserModel._init();
  void updateData(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    sName = json['sName'];
    bornDate =
        json['bornDate'] == null ? null : DateTime.parse(json['bornDate']);
    email = json['email'];
    gender = json['gender'];
    verifyCode = json['verifyCode'];
    isVerify = json['isVerify'];
    loginAuthkey = json['loginAuthkey'];
    loginAuthKeyUpdate = json['loginAuthKeyUpdate'];
    isProduces = json['isProduces'];
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    sName = json['sName'];
    bornDate =
        json['bornDate'] == null ? null : DateTime.parse(json['bornDate']);
    email = json['email'];
    gender = json['gender'];
    verifyCode = json['verifyCode'];
    isVerify = json['isVerify'];
    loginAuthkey = json['loginAuthkey'];
    loginAuthKeyUpdate = json['loginAuthKeyUpdate'];
    isProduces = json['isProduces'];
  }
  Map<String, dynamic> toJson(UserModel instance) => <String, dynamic>{
        'id': instance.id,
        'fName': instance.fName,
        'sName': instance.sName,
        'bornDate': instance.bornDate?.toIso8601String(),
        'email': instance.email,
        'gender': instance.gender,
        'verifyCode': instance.verifyCode,
        'isVerify': instance.isVerify,
        'loginAuthkey': instance.loginAuthkey,
        'loginAuthKeyUpdate': instance.loginAuthKeyUpdate,
        'isProduces': instance.isProduces,
      };
}
