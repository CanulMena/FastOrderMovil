part of 'register_form_bloc.dart';


class RegisterFormState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  const RegisterFormState({
    this.isPosting = false, //Este es el estado en el que se encuentra el formulario.
    this.isFormPosted = false, //Este es el estado en el que se encuentra el formulario.
    this.isValid = false,// no son validos hasta que las personas lo llenen.
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) {
    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
  
  @override
  List<Object> get props => [isValid, email, password, isFormPosted, isPosting];
}
