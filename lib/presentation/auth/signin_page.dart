import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool loading = false;
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
                      'SignIn',
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
                      'Welcome back! please enter your details',
                      style: ShadTheme.of(context).textTheme.muted,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const ShadImage.square(
                  'assets/svg/login.svg',
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
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
                        enabled: loading ? false : true,
                        icon: loading
                            ? const SizedBox.square(
                                dimension: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : null,
                        onPressed: () async {
                          String message = '';
                          if (formKey.currentState!.saveAndValidate()) {
                            setState(() => loading = true);
                            try {
                              await _firebaseAuth.signInWithEmailAndPassword(
                                email: formKey.currentState!.value['email'],
                                password:
                                    formKey.currentState!.value['password'],
                              );

                              formKey.currentState!.reset();
                              context.pushReplacement('/home');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                                message = 'Invalid login credentials.';
                              } else {
                                message = e.code;
                              }
                              ShadToaster.of(context).show(
                                ShadToast.destructive(
                                  title: const Text('Error'),
                                  description: Text(message),
                                ),
                              );
                            }
                            setState(() => loading = false);
                          } else {}
                        },
                        child: Text(loading ? 'Please Wait' : 'SignIn'),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 15,
                // ),
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
                //         child: Text('SignIn with Google'),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account? ',
                      style: ShadTheme.of(context).textTheme.p,
                    ),
                    GestureDetector(
                      onTap: () => context.go('/signup'),
                      child: Text(
                        'SignUp',
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
