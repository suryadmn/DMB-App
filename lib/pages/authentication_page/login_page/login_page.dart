import 'package:dmb_app/datas/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_auth.dart';
import '../../../utils/color_pallete_helper.dart';
import '../../../utils/shared_preferences_helper.dart';
import '../../../utils/snackbar_helper.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/input_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Global key auth formm
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  // Text editing contoller
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Provider
  ProviderAuth? providerAuth;

  @override
  void initState() {
    initialize();

    super.initState();
  }

  void initialize() {
    providerAuth = Provider.of<ProviderAuth>(context, listen: false);

    // Generate token and save to prefs
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
                  InputFieldWidget(
                    textEditingController: usernameController,
                    labelText: 'Username',
                    hintText: 'Please insert username',
                    errorMsgText: 'Please fill out this the username',
                  ),
                  const SizedBox(height: 8),
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
            ElevatedButtonWidget(
              buttonTitle: 'Login',
              isShowLoading:
                  Provider.of<ProviderAuth>(context).isLoadingCreateSession,
              onPressed: () async {
                if (formGlobalKey.currentState!.validate()) {
                  // Get token from prefs
                  await SharedPreferencesHelper.getToken(
                          key: SharedPreferencesHelper.prefsTokenKey)
                      .then((tokenValue) async {
                    if (tokenValue.isNotEmpty) {
                      // Do login
                      await providerAuth
                          ?.sessionLogin(
                        context: context,
                        username: usernameController.text,
                        password: passwordController.text,
                        requestToken: tokenValue,
                      )
                          .then((sessionLoginResponsevalue) {
                        if (sessionLoginResponsevalue.success ?? false) {
                          SnackbarHelper.show(
                            context,
                            "Successfully login",
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: ColorPalleteHelper.white,
                          );
                          Navigator.pushReplacementNamed(
                              context, splashScreenRoute);
                        } else {
                          SnackbarHelper.show(
                            context,
                            sessionLoginResponsevalue.statusMessage,
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor: ColorPalleteHelper.white,
                          );
                        }
                      });
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
