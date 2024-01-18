import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_view_stack.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Oops!',
            style: TextStyle(
                fontFamily: 'GT',
                fontSize: 40,
                color: Colors.pink,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'something went wrong',
            style: TextStyle(
                fontFamily: 'GT',
                fontSize: 15,
                color: Colors.pink,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset('assets/errorpage.png'),
          SizedBox(
            height: 10,
          ),
          Text(
            'Check your internet connection',
            style: TextStyle(
                fontFamily: 'GT',
                fontSize: 15,
                color: Colors.pink,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
                  ),
                  backgroundColor: Color.fromRGBO(
                    1,
                    1,
                    150,
                    1,
                  )),
              onPressed: () async {
                await controller.reload();
              },
              child: Text(
                'Try Again',
                style: TextStyle(color: Colors.white, fontFamily: 'GT'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
