
import 'package:syriagames/models/Auth/Register_validation_model.dart';
import 'package:syriagames/models/Auth/register_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final RegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterValidationLoadingState extends RegisterStates{}

class RegisterValidationSuccessState extends RegisterStates{
  final RegisterValidationModel registerValidationModel;

  RegisterValidationSuccessState(this.registerValidationModel);

}

class RegisterValidationErrorState extends RegisterStates{
  final RegisterValidationModel registerValidationModel;

  RegisterValidationErrorState(this.registerValidationModel);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}



