import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Form userForm({
  required List<Widget> children,
  required VoidCallback onSubmit,
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  return use(_Form(
    children: children,
    onSubmit: onSubmit,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
  ));
}

class _Form extends Hook<Form> {
  final List<Widget> children;
  final VoidCallback onSubmit;
  final Widget buttonChild;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const _Form({
    required this.children,
    required this.onSubmit,
    this.buttonChild: const Text("Submit"),
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });
  @override
  __FormState createState() => __FormState();
}

class __FormState extends HookState<Form, _Form> {
  final _formKey = GlobalKey<FormState>();

  @override
  Form build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: hook.mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment:
            hook.crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          for (var child in hook.children) child,
          ElevatedButton(
            child: hook.buttonChild,
            onPressed: () {
              if (_formKey.currentState!.validate()) return hook.onSubmit();
              return null;
            },
          ),
        ],
      ),
    );
  }
}
