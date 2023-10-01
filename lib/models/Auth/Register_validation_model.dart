// ignore_for_file: prefer_null_aware_operators

class RegisterValidationModel {
  String? message;
  Errors? errors;

  RegisterValidationModel({this.message, this.errors});

  RegisterValidationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = json['errors'] != null ?  Errors.fromJson(json['errors']) : null;
  }

}

class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? phone;
  List<String>? password;
  List<String>? confirmPassword;

  Errors({this.email, this.phone, this.password, this.confirmPassword});
  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'] !=null ? json['name'].cast<String>():null;
    email = json['email'] !=null ? json['email'].cast<String>():null;
    phone =json['phone'] !=null ? json['phone'].cast<String>():null;
    password = json['password'] !=null ? json['password'].cast<String>():null;
    confirmPassword = json['confirm_password'] !=null ? json['confirm_password'].cast<String>():null;
  }
}


