import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut();
            Future.delayed(const Duration(seconds: 3), () {
              context.pushReplacement('/');
            });
          } on Exception catch (e) {
            if (mounted) {
              ShadToaster.of(context).show(
                ShadToast.destructive(
                  title: const Text('Error'),
                  description: Text(e.toString()),
                ),
              );
            }
          }
        },
        icon: const Icon(CupertinoIcons.square_arrow_right),
      ),
    );
  }
}
