import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FinicPage extends StatefulWidget {
  final String url;
  static const String routeName = '/';
  static Route route(String url) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => FinicPage(url: url));
  }

  const FinicPage({super.key, required this.url});

  @override
  State<FinicPage> createState() => _FinicPageState();
}

class _FinicPageState extends State<FinicPage> {
  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  late final String url;
  final WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
          child: SafeArea(
        bottom: false,
        child: WebViewWidget(
            controller: controller
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.isEmpty) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(url))),
      )),
    );
  }
}
