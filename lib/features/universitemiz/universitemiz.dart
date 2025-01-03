import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../product/constants/url_constants.dart';
import '../../core/provider/webpage_state.dart';

class UniversitemizSayfasi extends StatelessWidget {
  final String sayfa;

  const UniversitemizSayfasi({Key? key, required this.sayfa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webPageState = Provider.of<WebPageState>(context, listen: false);
    final webUrl = _getWebUrl(sayfa);

    return Scaffold(
      appBar: AppBar(
        title: Text(sayfa),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(webUrl)),
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
              ),
            ),
            onLoadStart: (controller, url) {
              webPageState.setLoading(true); // Yükleme başladı
            },
            onLoadStop: (controller, url) async {
              await controller.evaluateJavascript(source: '''
                const bottomBar = document.querySelector('.bottom-bar');
                if (bottomBar) {
                  bottomBar.setAttribute('style', 'display: none !important;');
                }
                document.querySelector('header').style.display = 'none';
                document.querySelector('.breadcrumb-container').style.display = 'none';
              ''');
              webPageState.setLoading(false); // Yükleme tamamlandı
            },
          ),
          Consumer<WebPageState>(
            builder: (context, state, child) {
              return state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  String _getWebUrl(String sayfa) {
    // Yönetim elemanına göre web URL'i oluşturma mantığı
    switch (sayfa) {
      case 'Tarihçe':
        return UniversitemizUrlConstants.TARIHCE;
      case 'Misyon-Vizyon':
        return UniversitemizUrlConstants.MISYON_VIZYON;
      case 'Aday Öğrenci':
        return UniversitemizUrlConstants.ADAY_OGRENCI;
      case 'Öğrenci Portalı':
        return UniversitemizUrlConstants.OGRENCI_PORTALI;  
      default:
        return 'https://www.biruni.edu.tr'; // Varsayılan URL
    }
  }
}
