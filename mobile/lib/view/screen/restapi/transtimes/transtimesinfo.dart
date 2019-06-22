import 'package:dambi/properties/InformationProperties.dart';
class TransTimesInfo {
  final int len;

  TransTimesInfo({this.len, });

  factory TransTimesInfo.fromJson(List<dynamic> json) {
    InformationProperties.translist = json;
    return TransTimesInfo(
      len: json.length,
    );
  }
}