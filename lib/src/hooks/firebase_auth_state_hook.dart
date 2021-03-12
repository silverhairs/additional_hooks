import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Widget useAppWithFirebaseAuthState({
  required Widget loggedInStateHomeScreen,
  required Widget loggedOutStateHomeScreen,
}) {
  return use(
    _AppWithFirebaseAuthState(
      loggedInStateHomeScreen: loggedInStateHomeScreen,
      loggedOutStateHomeScreen: loggedOutStateHomeScreen,
    ),
  );
}

class _AppWithFirebaseAuthState extends Hook<Widget> {
  final Widget loggedInStateHomeScreen;
  final Widget loggedOutStateHomeScreen;

  const _AppWithFirebaseAuthState({
    required this.loggedInStateHomeScreen,
    required this.loggedOutStateHomeScreen,
  });

  @override
  __AppWithAuthStateState createState() => __AppWithAuthStateState();
}

class __AppWithAuthStateState
    extends HookState<Widget, _AppWithFirebaseAuthState> {
  Widget home = Scaffold(
    body: Center(child: SizedBox(child: CircularProgressIndicator())),
  );
  @override
  void initHook() {
    super.initHook();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null)
        setState(() => home = hook.loggedOutStateHomeScreen);
      else
        setState(() => home = hook.loggedInStateHomeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return home;
  }
}
