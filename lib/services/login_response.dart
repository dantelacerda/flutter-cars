class LoginResponse {
  final String status;
  final String msg;

  LoginResponse(this.status, this.msg);

  LoginResponse.fromJson(Map<String, dynamic> map):
      status = map["status"],
      msg = map["msg"];

  bool isOk() {
    return status == "OK";
  }

}