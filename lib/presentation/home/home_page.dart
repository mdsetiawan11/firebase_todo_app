import 'package:firebase_todo_app/presentation/home/profile_page.dart';
import 'package:firebase_todo_app/presentation/home/todo_page.dart';
import 'package:flutter/material.dart';
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
