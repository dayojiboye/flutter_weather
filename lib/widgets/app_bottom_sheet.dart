import 'package:flutter/material.dart';

class AppBottomSheet {
  const AppBottomSheet({
    required this.context,
    required this.child,
    this.showDragHandle = true,
    this.onDismiss,
  });

  final BuildContext context;
  final Widget child;
  final bool showDragHandle;
  final Function()? onDismiss;

  void open() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(48),
        ),
      ),
      builder: (ctx) => SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 0),
              curve: Curves.decelerate,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    ).whenComplete(() => onDismiss!());
  }
}
