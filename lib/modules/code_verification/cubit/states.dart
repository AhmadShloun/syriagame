abstract class CodeVerificationStates{}

class CodeVerificationInitialState extends CodeVerificationStates{}

class CodeVerificationLoadingState extends CodeVerificationStates{}

class CodeVerificationSuccessState extends CodeVerificationStates{
  // final CodeVerificationModel loginModel;
  //
  // CodeVerificationSuccessState(this.loginModel);
}

class CodeVerificationErrorState extends CodeVerificationStates{
  // LoginModel loginModel;
  // LoginErrorState(this.loginModel);
}

