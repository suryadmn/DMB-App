import 'package:dmb_app/datas/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_auth.dart';
import '../../../utils/color_pallete_helper.dart';
import '../../../utils/shared_preferences_helper.dart';
import '../../../utils/snackbar_helper.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/input_field_widget.dart';

/// LoginPage widget, responsible for displaying the login form and handling
/// user authentication.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Global key for managing the form state.
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  /// Text controllers for capturing user input.
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Provider for authentication logic.
  ProviderAuth? providerAuth;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  /// Initializes the necessary resources for the login page, such as generating
  /// an authentication token.
  void initialize() {
    providerAuth = Provider.of<ProviderAuth>(context, listen: false);

    // Generates a new token and saves it to shared preferences.
    providerAuth?.generateToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 50),
            Form(
              key: formGlobalKey,
              child: Column(
                children: [
                  // Username input field
                  InputFieldWidget(
                    textEditingController: usernameController,
                    labelText: 'Username',
                    hintText: 'Please insert username',
                    errorMsgText: 'Please fill out the username',
                  ),
                  const SizedBox(height: 8),

                  // Password input field
                  InputFieldWidget(
                    textEditingController: passwordController,
                    isPasswordField: true,
                    labelText: 'Password',
                    hintText: 'Please insert password',
                    errorMsgText: 'Please fill out the password',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Login button with loading state management
            ElevatedButtonWidget(
              buttonTitle: 'Login',
              isShowLoading:
                  Provider.of<ProviderAuth>(context).isLoadingCreateSession,
              onPressed: () {
                login();
              },
            )
          ],
        ),
      ),
    );
  }

  /// Handles the login process by validating the form and sending a login request.
  ///
  /// If successful, it navigates the user to the next screen; otherwise, it displays
  /// an error message.
  Future<void> login() async {
    // Check if the form is valid
    if (formGlobalKey.currentState!.validate()) {
      // Retrieve token from shared preferences
      await SharedPreferencesHelper.getToken(
              key: SharedPreferencesHelper.prefsTokenKey)
          .then((tokenValue) async {
        // Check if the retrieved token is not empty
        if (tokenValue.isNotEmpty) {
          // Send login request using the provided credentials and token
          await providerAuth
              ?.sessionLogin(
            context: context,
            username: usernameController.text,
            password: passwordController.text,
            requestToken: tokenValue,
          )
              .then((sessionLoginResponseValue) async {
            // If login is successful
            if (sessionLoginResponseValue.success ?? false) {
              await SharedPreferencesHelper.setNewToken(
                  token: sessionLoginResponseValue.requestToken ?? "");

              await SharedPreferencesHelper.setHasLogin();

              SnackbarHelper.show(
                context,
                "Successfully logged in",
                backgroundColor: Theme.of(context).primaryColor,
                textColor: ColorPalleteHelper.white,
              );

              // Navigate to the main page after successful login
              Navigator.pushReplacementNamed(context, mainRoute);
            } else {
              // Display an error message if login fails
              SnackbarHelper.show(
                context,
                sessionLoginResponseValue.statusMessage ?? "",
                backgroundColor: Theme.of(context).primaryColor,
                textColor: ColorPalleteHelper.white,
              );
            }
          });
        }
      });
    }
  }
}
