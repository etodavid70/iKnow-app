import 'package:flutter/material.dart';
import 'src/navigation_controls.dart';
import 'src/web_view_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'src/menu.dart';
import 'src/errorpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

      routes: {
        '/': (contextual) => WebViewApp(),
        '/error': (contextual) => ErrorPage()
      },
      theme: ThemeData(useMaterial3: true),
      // home: const WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  bool _notTimedout = true;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://iknow.pythonanywhere.com'),
      );

    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            print(
                "Web resource error: ${error.errorCode} ${error.description}");
            // Handle the error appropriately, e.g., display an error message to the user.
          },
          onPageFinished: (url) {
            _checkForErrors();
          },
        ),
      );
  }

  void _checkForErrors() async {
    controller.setNavigationDelegate(NavigationDelegate(
      onWebResourceError: (error) {
        print("Web resource error: ${error.errorCode} ${error.description}");

        if (error.errorCode == 408 || error.errorCode == 404) {
          setState(() {
            _notTimedout = false;
          });
        }
        // Handle the error appropriately, e.g., display an error message to the user.
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
      ),
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     NavigationControls(controller: controller),
      //     SizedBox(
      //       width: 40,
      //     )
      //     // Menu(controller: controller,)
      //   ],
      // ),
      body: _notTimedout ? WebViewStack(controller: controller) : ErrorPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // fixedColor: Color.fromRGBO(0, 0, 128, 1),
        unselectedItemColor: Color.fromRGBO(0, 0, 128, 1),
        selectedItemColor: Color.fromRGBO(0, 0, 128, 1),
        items: [
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.language_rounded), label: 'Website'),
          BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.home),
                onTap: () async {
                  await controller.loadRequest(
                      Uri.parse('https://iKnow.pythonanywhere.com/'));
                },
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: GestureDetector(
                child: const Icon(
                  Icons.arrow_circle_left,
                  color: Color.fromRGBO(0, 0, 128, 1),
                ),
                onTap: () async {
                  
                },
              ),
              label: 'back'),

          BottomNavigationBarItem(
              icon: const Icon(
                Icons.arrow_circle_right_rounded,
                color: Color.fromRGBO(0, 0, 128, 1),
              ),
              label: 'forward'),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.replay,
            ),
            label: 'reload',
          ),
        ],
        onTap: (index) async{
    switch (index) {
      //home
      case 0:   
  await controller.loadRequest(
  Uri.parse('https://iKnow.pythonanywhere.com/'));
        break;

//back
      case 1:
      final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('No back history item')),
                    );
                    return;
                  }
        break;

//forward
      case 2:
      final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('No foward history item')),
                    );
                    return;
                  }
      
        
        break;
      case 3:
        // reload
       controller.reload();
       
        break;
    }
        }
      ),
    );
  }
}
