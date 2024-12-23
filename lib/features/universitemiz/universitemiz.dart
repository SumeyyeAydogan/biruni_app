import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../product/constants/url_constants.dart';
import '../../core/provider/webpage_state.dart';
import 'widget/web_page_body.dart';

class UniversitemizSayfasi extends StatelessWidget {
  final String sayfa;

  const UniversitemizSayfasi({Key? key, required this.sayfa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WebPageState(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(sayfa),
        ),
        body: WebPageBody(sayfa: sayfa),
      ),
    );
  }
}
