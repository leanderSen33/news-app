import 'package:news_app/src/model/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  late final String status;
  // code and message fields refer to the errors that the response might throw.
  late final String? code;
  late final String? message;
  late final List<Article>? articles; 

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  ApiResponse();
}
