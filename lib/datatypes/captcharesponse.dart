class CaptchaResponse {
  String? message;
  String? uuid;
  int? id;

  CaptchaResponse({this.message, this.uuid, this.id});

  CaptchaResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    uuid = json['uuid'].toString();
    id = int.parse(json['id'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['uuid'] = uuid;
    data['id'] = id;
    return data;
  }

  CaptchaResponse.dummy() {
    message = "dummy";
    uuid = "dummy";
    id = 0;
  }
}
