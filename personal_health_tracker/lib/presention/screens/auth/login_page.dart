// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/presention/screens/auth/bloc/auth_bloc.dart';
import 'package:personal_health_tracker/presention/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc authBloc =AuthBloc();
  // text editing controllers
  final emailController =TextEditingController();

  final passwordController =TextEditingController();

   @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    emailController.dispose();
    passwordController .dispose();
    authBloc.close();
    super.dispose();
  }

  // sign user in method
  void signUserIn(){}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      
      listener: (context, state) {
        // TODO: implement listener
        
        if (state is LogInSuccessState) {
          print(state);
          context.go('/');
        }
        else if (state is LoginNavigateToSignupState) {
          context.go('/signup');
        }
        else if (state is LogInErrorState) {
          final snackBar = SnackBar(
            content: Text(state.error),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 56, 41, 81),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
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
                    SizedBox(height: 20,),
                    //curcle or avator logo
                    CircleAvatar(
                      // backgroundColor: Colors.white,
                      backgroundImage: AssetImage("image/logo.png"),
                      radius:30 ,
                    ),
                      
                    SizedBox(height: 15,),
                      
                    //text
                    Text(
                      "ጎመን በጤና",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 72, 71, 71)
                  
                        ),
                    ),
                      
                    SizedBox(height: 50,),
                    //email text field
                    MyTextField(
                      controller: emailController, 
                      hintText: "Email", 
                      obscureText: false
                      ),
                    SizedBox(height: 10,),
                    //password textfeild
                     MyTextField(
                      controller: passwordController, 
                      hintText: "Password", 
                      obscureText: true
                      ),
                    SizedBox(height: 50,),
                    // sing up btn
                    ElevatedButton(
                      onPressed: () {
                        authBloc.add(LogInEvent(
                            useremail: emailController.text,
                            password: passwordController.text));
                      },
                      child: const Text('Login'),
                    ),
                    SizedBox(height: 10,),
                    // textfelid for login link  
                    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account. ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 133, 95, 176),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                authBloc.add(NavigateToSignUpPageEvent());
                              },
                              child:const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 127, 85, 175),
                                ),
                              ),
                            ),
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