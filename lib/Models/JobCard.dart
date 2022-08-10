class JobCard {
  String id;
  String cardNo;
  DateTime createdAt;
  String sirveces;
  bool done;
  String phone;
  String name;
  String carNo;
  String km;
  String model;
  String nClyn;
  String chassiNo;
  String signature;

  JobCard(
      {required this.cardNo,
      required this.createdAt,
      required this.sirveces,
      required this.done,
      required this.id,
      required this.carNo,
      required this.chassiNo,
      required this.km,
      required this.model,
      required this.nClyn,
      required this.name,
      required this.phone,
      required this.signature});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'cardNo': cardNo,
        'createdAt': createdAt,
        'sirveces': sirveces,
        'done': done,
        'phone': phone,
        'name': name,
        'carNo': carNo,
        'km': km,
        'model': model,
        'nClyn': nClyn,
        'chassiNo': chassiNo,
        'signature': signature
      };

  static JobCard fromJson(Map<String, dynamic> json) => JobCard(
      cardNo: json['cardNo'],
      createdAt: json['createdAt'],
      sirveces: json['sirveces'],
      done: json['done'],
      id: json['id'],
      carNo: json['carNo'],
      chassiNo: json['chassiNo'],
      km: json['km'],
      model: json['model'],
      nClyn: json['nClyn'],
      name: json['name'],
      phone: json['phone'],
      signature: json['signature']);
}
