import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/presentation/home/profile_page.dart';
import 'package:firebase_todo_app/presentation/home/todo_page.dart';
import 'package:firebase_todo_app/providers/theme_provider.dart';
import 'package:firebase_todo_app/utils/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                const Text('Dark'),
                const SizedBox(
                  height: 5,
                ),
                ShadSwitch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Color'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 600,
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: colorScheme.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            themeProvider.changeColorScheme(index);
                          },
                          child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: themeProvider.selectedColorScheme ==
                                            index
                                        ? colorScheme[index].color
                                        : Colors.transparent)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorScheme[index].color),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Todo', style: ShadTheme.of(context).textTheme.h3),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(LucideIcons.settings2),
            );
          }),
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
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  LucideIcons.database,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
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
