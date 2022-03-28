import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import '../../../domain/auth/failures/auth_failure.dart';
import '../../../injection.dart';

class SignInFormPage extends StatelessWidget {
  const SignInFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: BlocConsumer<SignInFormBloc, SignInFormState>(
          listener: (context, state) {
            if (state.authFailureOrSuccessOption.isSome()) {
              final authFailureOrSuccess =
                  state.authFailureOrSuccessOption.getOrElse(() => right(unit));
              authFailureOrSuccess.fold(
                (l) {
                  final String message = _getErrorMessage(l);
                  final snackBar = SnackBar(
                    content: Text(message),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                (r) => null,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildEmailTextForm(context),
                    const SizedBox(
                      height: 24,
                    ),
                    _buildPasswordFormField(context),
                    const SizedBox(
                      height: 24,
                    ),
                    _buildButtonsRow(state, context),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildGoogleSignInButton(state, context)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ElevatedButton _buildGoogleSignInButton(
    SignInFormState state,
    BuildContext context,
  ) {
    return ElevatedButton(
      child: const Text('Sign In with Google'),
      onPressed: state.isSubmitting
          ? null
          : () {
              BlocProvider.of<SignInFormBloc>(context).add(
                const SignInFormEvent.signInWithGooglePressed(),
              );
            },
    );
  }

  Row _buildButtonsRow(
    SignInFormState state,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: state.isSubmitting
                ? null
                : () {
                    BlocProvider.of<SignInFormBloc>(context).add(
                      const SignInFormEvent.signInWithEmailAndPasswordPressed(),
                    );
                  },
            child: const Text('Sign In'),
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: state.isSubmitting
                ? null
                : () {
                    BlocProvider.of<SignInFormBloc>(context).add(
                      const SignInFormEvent
                          .registerWithEmailAndPasswordPressed(),
                    );
                  },
            child: const Text('Create account'),
          ),
        ),
      ],
    );
  }

  TextFormField _buildPasswordFormField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
        hintText: 'Password',
      ),
      onChanged: (value) {
        BlocProvider.of<SignInFormBloc>(context).add(
          SignInFormEvent.passwordChanged(
            value,
          ),
        );
      },
    );
  }

  TextFormField _buildEmailTextForm(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
        hintText: 'E-mail',
      ),
      onChanged: (value) {
        BlocProvider.of<SignInFormBloc>(context).add(
          SignInFormEvent.emailChanged(
            value,
          ),
        );
      },
    );
  }

  String _getErrorMessage(AuthFailure l) {
    return l.map(
      cancelledByUser: (_) => 'Sign in with Google cancelled by user',
      serverError: (_) => 'Internal Server Error, please try again',
      emailAlreadyInUse: (_) => 'Email already in use',
      invalidEmailAndPasswordCombination: (_) =>
          'Invalid e-mail and password combination',
      passwordTooWeak: (_) => 'Your password is too weak',
      invalidEmail: (_) => 'Your email is invalid',
    );
  }
}
