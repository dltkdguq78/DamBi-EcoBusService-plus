

class LogInInfo {

  final String result;
  final String accesstoken;
  final String info;

  LogInInfo({this.result, this.accesstoken, this.info});

  factory LogInInfo.fromJson(Map<String, dynamic> json) {
    if(json['result'] == "success") {
      return LogInInfo(
        result: json['result'],
        accesstoken: json['accesstoken'],
      );
    }
    else{
      return LogInInfo(
        result:json['result'],
        info:json['info'],
      );
    }
  }
}