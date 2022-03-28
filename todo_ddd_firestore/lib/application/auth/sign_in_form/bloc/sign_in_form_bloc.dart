import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/auth/failures/auth_failure.dart';
import '../../../../domain/auth/entities/email_address.dart';
import '../../../../domain/auth/repositories/i_auth_facade.dart';
import '../../../../domain/auth/entities/password.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<EmailChanged>(
      (event, emit) {
        emit(
          state.copyWith(
            emailAddress: EmailAddress(
              event.emailString,
            ),
            authFailureOrSuccessOption: none(),
          ),
        );
      },
    );
    on<PasswordChanged>(
      (event, emit) {
        emit(
          state.copyWith(
            password: Password(
              event.passwordString,
            ),
            authFailureOrSuccessOption: none(),
          ),
        );
      },
    );
    on<RegisterWithEmailAndPasswordPressed>(
      (event, emiter) async {
        await _performActionOnAuthFacadeWithEmailAndPassword(
          event,
          emiter,
          _authFacade.registerWithEmailAndPassword,
        );
      },
    );
    on<SignInWithEmailAndPasswordPressed>(
      (event, emit) async {
        await _performActionOnAuthFacadeWithEmailAndPassword(
          event,
          emit,
          _authFacade.signInWithEmailAndPassword,
        );
      },
    );
    on<SignInWithGooglePressed>(
      (event, emit) async {
        emit(
          state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ),
        );
        final response = await _authFacade.signInWithGoogle();
        emit(
          state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(response),
          ),
        );
      },
    );
  }

  FutureOr<void> _performActionOnAuthFacadeWithEmailAndPassword(
    Object? event,
    Emitter<SignInFormState> emit,
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress email,
      required Password password,
    })
        fowardedCall,
  ) async {
    Either<AuthFailure, Unit>? failureOrSuccess;
    final isPasswordValid = state.password.isValid();
    final isEmailValid = state.emailAddress.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );
      failureOrSuccess = await fowardedCall(
        email: state.emailAddress,
        password: state.password,
      );
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
