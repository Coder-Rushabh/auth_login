import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/textfield.dart';
import 'package:login_auth/components/My_button.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();


  void SignUpUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
    
        if (passwordController.text == confirmPasswordController.text){
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        }else{
          showErrorMessage("Password don't match");
        }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

     showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          title: Center(child: Text(message)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
           Container(child: Image(image: AssetImage("assets/images/logo.png")),
           height: 100, width: 100,),
            SizedBox(
              height: 20,
            ),
            Text(
              "Let's create an account for you!",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            My_TextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            My_TextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),

             My_TextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            
            
            const SizedBox(
              height: 10,
            ),
          
            const SizedBox(
              height: 25,
            ),
            MyButton(onTap: SignUpUser, text: ("Sign Up"),),
            const SizedBox(
              height: 30,
            ),
           
            const SizedBox(
              height: 20,
            ),
          
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Already have an account? "),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    "Login here!",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ))),
    );
  }
}
