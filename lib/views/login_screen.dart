import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task_manager_app/controller/providers/auth_provider.dart';
import 'package:flutter_task_manager_app/network_resources/authentication.dart';
import 'package:flutter_task_manager_app/routes/routes.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final userNameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    'assets/images/maid_logo.svg',
                    color: const Color(0xff436AB2),),
                )),
            const SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal
                              )
                          ),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.teal,),
                          focusColor: Colors.black87,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal
                              )
                          )
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal
                              )
                          ),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.teal,),
                          focusColor: Colors.black87,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal
                              )
                          )
                      ),
                    ),
                  ),
                  Consumer<AuthProvider>(builder: (context, authProvider, child){
                    return OutlinedButton(
                        onPressed: (){
                          if(userNameController.text.isEmpty || passwordController.text.isEmpty){
                            Utils.showMessages('user name or password is empty');
                          }else if(userNameController.text.isEmpty && passwordController.text.isEmpty){
                            Utils.showMessages('user name & password are empty');
                          }else{
                            authProvider.saveUser(userNameController.text.toString().trim(),
                                passwordController.text.toString().trim()).whenComplete((){
                              Navigator.pushNamed(context, Routes.todoScreenRoute);
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide.none
                            )
                        ),
                        child: authProvider.isLoading ? const Center(
                          child: CircularProgressIndicator(strokeCap: StrokeCap.round, color: Colors.white,),
                        ) : const Text('Login', style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),));
                  })
                ],
              ),
            )],
        ),
      ),
    );
  }
}
