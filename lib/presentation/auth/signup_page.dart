import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscure = false;
  final formKey = GlobalKey<ShadFormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ShadForm(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 130,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SignUp',
                      style: ShadTheme.of(context).textTheme.h2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter your details',
                      style: ShadTheme.of(context).textTheme.muted,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const ShadImage.square(
                  'assets/svg/signup.svg',
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                ShadInputFormField(
                  id: 'name',
                  placeholder: const Text('Name'),
                  obscureText: obscure,
                  prefix: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ShadImage.square(size: 16, Icons.person),
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Name cannot be empty!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ShadInputFormField(
                  id: 'email',
                  placeholder: const Text('Email'),
                  obscureText: obscure,
                  prefix: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ShadImage.square(size: 16, LucideIcons.mail),
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Please enter a valid email!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ShadInputFormField(
                  id: 'password',
                  placeholder: const Text('Password'),
                  obscureText: obscure,
                  prefix: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ShadImage.square(size: 16, LucideIcons.lock),
                  ),
                  suffix: ShadButton(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.zero,
                    decoration: const ShadDecoration(
                      secondaryBorder: ShadBorder.none,
                      secondaryFocusedBorder: ShadBorder.none,
                    ),
                    icon: ShadImage.square(
                      size: 16,
                      obscure ? LucideIcons.eyeOff : LucideIcons.eye,
                    ),
                    onPressed: () {
                      setState(() => obscure = !obscure);
                    },
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Please enter a strong password!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ShadButton(
                        child: const Text('SignUp'),
                        onPressed: () async {
                          String message = '';
                          if (formKey.currentState!.saveAndValidate()) {
                            try {
                              await _firebaseAuth
                                  .createUserWithEmailAndPassword(
                                // instantiated earlier on: final _firebaseAuth = FirebaseAuth.instance;
                                email:
                                    formKey.currentState!.value['email'].trim(),
                                password: formKey
                                    .currentState!.value['password']
                                    .trim(),
                              );
                              formKey.currentState!.reset();
                              Future.delayed(const Duration(seconds: 3), () {
                                context.pushReplacement('/home');
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                message = 'The password provided is too weak.';
                              } else if (e.code == 'email-already-in-use') {
                                message =
                                    'An account already exists with that email.';
                              }
                              ShadToaster.of(context).show(
                                ShadToast.destructive(
                                  title: const Text('Error'),
                                  description: Text(message),
                                ),
                              );
                            } catch (e) {
                              ShadToaster.of(context).show(
                                ShadToast.destructive(
                                  title: const Text('Error'),
                                  description: Text(message),
                                ),
                              );
                            }
                          } else {
                            debugPrint('validation failed');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Or',
                //       style: ShadTheme.of(context).textTheme.p,
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: ShadButton.secondary(
                //         child: Text('SignUp with Google'),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: ShadTheme.of(context).textTheme.p,
                    ),
                    GestureDetector(
                      onTap: () => context.go('/signin'),
                      child: Text(
                        'SignIn',
                        style: ShadTheme.of(context)
                            .textTheme
                            .p
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
