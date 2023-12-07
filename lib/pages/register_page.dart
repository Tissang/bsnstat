  import 'package:bsnstat/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:bsnstat/components/my_button.dart';
  import 'package:bsnstat/components/my_textfield.dart';
  import 'package:bsnstat/components/square_tile.dart';


  class RegisterPage extends StatefulWidget {
    final Function()? onTap;
    const RegisterPage({super.key, required this.onTap});

    @override
    State<RegisterPage> createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    // text editing controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
     final confirmPasswordController = TextEditingController();

    // sign user up method
    void signUserUp() async {
      
      // show loading circle
        showDialog(context: context, builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // try creating the user
      try {
        // check if password is confirmed
        if (passwordController.text == confirmPasswordController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, 
            password: passwordController.text
          );
        } else {
          // show error message, passwords don't match
          showErrorMessage("Passwords don't match!");
        }

        // pop the loading circle
        Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        // pop the loading circle
          Navigator.pop(context);

        //show error message
        showErrorMessage(e.code);
      }
    }

      // error message to user
      void showErrorMessage(String message) {
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog (
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                
                    // logo
                    const Icon(
                      Icons.account_box,
                      size: 94,
                    ),
                
                    const SizedBox(height: 20),
                
                    // let's create an account for you!
                    Text(
                      'Let\'s create an account for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 19,
                        
                      ),
                    ),
                
                    const SizedBox(height: 25),
                
                    // email textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                
                    const SizedBox(height: 10),
                
                    // password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                
                    const SizedBox(height: 10),

                    // confirm password textfield
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm password',
                      obscureText: true,
                    ),
                
                    const SizedBox(height: 50),
                
                    // sign in button
                    MyButton(
                      text: "Sign Up",
                      onTap: signUserUp,
                    ),
                
                    const SizedBox(height: 50),
                
                    // or continue with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    const SizedBox(height: 30),
                
                    // google  sign in button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // google button
                        SquareTile(
                          onTap: () => AuthService().signInWithGoogle(),
                          imagePath: 'lib/images/google.png',
                          ),
                      ],
                    ),
                
                    const SizedBox(height: 25),
                
                    // already have an account? login now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
