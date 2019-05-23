class Response {
  final String status;
  final String msg;
  String url;

  Response(this.status, this.msg);

  Response.fromJson(Map<String, dynamic> map):
      status = map["status"],
      msg = map["msg"],
      url = map["url"];

  bool isOk() {
    return status == "OK";
  }

}