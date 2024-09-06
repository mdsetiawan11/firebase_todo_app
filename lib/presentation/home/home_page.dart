import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/presentation/home/profile_page.dart';
import 'package:firebase_todo_app/presentation/home/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Todo',
            style: ShadTheme.of(context)
                .textTheme
                .h3
                .copyWith(color: Colors.white),
          ),
          backgroundColor: ShadTheme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: () {
                showShadDialog(
                  context: context,
                  builder: (context) => ShadDialog.alert(
                    constraints: const BoxConstraints(maxWidth: 300),
                    title: const Text('SignOut'),
                    description: const Text('Are you sure?'),
                    actionsAxis: Axis.horizontal,
                    actionsMainAxisAlignment: MainAxisAlignment.center,
                    actions: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ShadButton.outline(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ShadButton(
                          child: const Text('Yes'),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              Future.delayed(const Duration(seconds: 1), () {
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
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                LucideIcons.logOut,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  LucideIcons.database,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TodoPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
