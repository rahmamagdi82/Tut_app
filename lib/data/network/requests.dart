class LoginRequest{
  String email;
  String password;
  LoginRequest(this.email,this.password);
}

class RegisterRequest{
  String name;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterRequest(this.name,this.countryMobileCode,this.mobileNumber,this.email,this.password,this.profilePicture);
}