import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, super.key});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color.fromRGBO(0, 0, 128, 1),
          ),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoBack()) {
              await controller.goBack();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No back history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_circle_right_rounded,
            color: Color.fromRGBO(0, 0, 128, 1),
          ),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            if (await controller.canGoForward()) {
              await controller.goForward();
            } else {
              messenger.showSnackBar(
                const SnackBar(content: Text('No forward history item')),
              );
              return;
            }
          },
        ),
      ],
    );
  }
}
