import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:info_popup/info_popup.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key}); // MODIFY

  final WebViewController controller; // ADD

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    widget.controller.setNavigationDelegate(
      NavigationDelegate(
       
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
            
              _isLoaded=false;
            
          });
        },
        onProgress: (progress) {
          setState(() {
            
              _isLoaded=false;
            
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) async {
      
          setState(() {
            loadingPercentage = 100;
            _isLoaded=true;
          });
        
        },
      ),
    );

    // ...to here.
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  _isLoaded? WebViewWidget(controller: widget.controller):Center(

        child: SpinKitCubeGrid(
               color: Color.fromRGBO(0, 0, 200, 1),
    
      ),
      )
    );
    // return Stack(
    //   children: [
    //     WebViewWidget(
    //       controller: widget.controller,
    //     ),
    //     // if (loadingPercentage < 100)
    //     //   InfoPopupWidget(
    //     //     contentTitle: '',
    //     //     child: SpinKitThreeInOut(
    //     //       color: Color.fromRGBO(0, 0, 200, 1),
    //     //     ),
    //     //   ),

    //   ],
    // );
  }
}
