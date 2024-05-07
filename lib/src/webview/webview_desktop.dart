import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:webf/webf.dart';
import 'package:webview_windows/webview_windows.dart';

class WebviewDesktop extends StatefulWidget {
  final String url;

  const WebviewDesktop({Key? key, required this.url}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<WebviewDesktop> createState() => _WebviewDesktopState(url: url);
}

class _WebviewDesktopState extends State<WebviewDesktop> {

  final String url;
  _WebviewDesktopState({required this.url});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    final Size viewportSize = queryData.size;
    return (!Platform.isWindows) ? Column(
      children: [
        WebF(
          viewportWidth: viewportSize.width - queryData.padding.horizontal,
          viewportHeight: viewportSize.height - queryData.padding.vertical,
          bundle: WebFBundle.fromUrl(url),
        ),
      ],
    ): WebviewWindows(url: url)
    ;
  }
}

class WebviewWindows extends StatefulWidget {
  final String url;

  const WebviewWindows({Key? key, required this.url}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<WebviewWindows> createState() => _WebviewWindowsState(url: url);
}

class _WebviewWindowsState extends State<WebviewWindows> {
  final String url;
  final _controller = WebviewController();

  _WebviewWindowsState({required this.url});

  @override
  void initState() {
    super.initState();
    initializeWebview();
  }

  void initializeWebview() async {
    await _controller.initialize();
    _controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Webview(
      _controller,
    );
  }
}
