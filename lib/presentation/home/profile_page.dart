import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  UserService userService = UserService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        final uid = user.uid;
        var userProfile = await userService.getUserProfile(uid);
        setState(() {
          name = userProfile['name'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text('Error: $errorMessage'),
      );
    }

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const ShadAvatar(
          size: Size.square(60),
          'https://app.requestly.io/delay/2000/avatars.githubusercontent.com/u/124599?v=4',
          placeholder: Icon(LucideIcons.circleUser),
        ),
        Text(
          'Hello, $name',
          style: ShadTheme.of(context).textTheme.p,
        ),
      ],
    );
  }
}
