import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeView extends StatefulWidget {
  final String url;
  YouTubeView(this.url);
  @override
  _YouTubeViewState createState() => _YouTubeViewState();
}

class _YouTubeViewState extends State<YouTubeView> {
  final Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("YouTube",style: GoogleFonts.montserrat(
              fontSize:20,
              color:Colors.white
            ),),
          ),
          backgroundColor: Colors.red
        ),
        body: WebView(
          initialUrl: 'https://youtube.com',
          onWebViewCreated: (WebViewController webviewcontroller){
            setState(() {
              controller.complete(webviewcontroller);
            });
          }

        ),
    );
  }
}