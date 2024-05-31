import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_health_tracker/presention/screens/auth/bloc/auth_bloc.dart';
import 'package:personal_health_tracker/presention/screens/auth/signup_page.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class AdminLogPage extends StatefulWidget {
  final AuthBloc adminBloc = AuthBloc();

  @override
  State<AdminLogPage> createState() => _AdminLogPageState();
}

class _AdminLogPageState extends State<AdminLogPage> {
  final AuthBloc authBloc = AuthBloc();
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signAdminIn() {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is AdminLogErrorState) {
          final snackBar = SnackBar(
            content: Text(state.error),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if (state is AdminLogSuccessState) {
          print(state);
          Navigator.pushReplacementNamed(context, 'home');
        }
        else if (state is AdminLogNavigateToSignupState) {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        }
        

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 56, 41, 81),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 234, 234, 234),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFB1B1B1),
                      offset: Offset(3, 3),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-10, -10),
                      blurRadius: 10,
                    ),
                  ],
                ),
                width: 350.0,
                height: 500.0,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    //curcle or avator logo
                    const CircleAvatar(
                      // backgroundColor: Colors.white,
                      backgroundImage: AssetImage("image/logo.png"),
                      radius: 30,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //text
                    const Text(
                      "ጎመን በጤና",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 72, 71, 71)),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    //email text field
                    MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false),
                    const SizedBox(
                      height: 10,
                    ),
                    //password textfeild
                    MyTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true),
                    const SizedBox(
                      height: 50,
                    ),
                    // sing up btn
                   ElevatedButton(
                              onPressed: () {
                                // Submit button logic
                                authBloc.add(AdminLogEvent(
                                      useremail: emailController.text,
                                      password: passwordController.text));
                                },
                              child: const Text('Login as Admin'),
                            ),
                    const SizedBox(
                      height: 10,
                    ),
                    // textfelid for login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 133, 95, 176),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            authBloc.add(AdminLogNavigateToSignUpPageEvent());
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 133, 95, 176),
                            ),
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
