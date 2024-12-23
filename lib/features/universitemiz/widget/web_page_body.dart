import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../../product/constants/url_constants.dart';
import '../../../core/provider/webpage_state.dart';

class WebPageBody extends StatelessWidget {
  final String sayfa;

  const WebPageBody({Key? key, required this.sayfa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webPageState = Provider.of<WebPageState>(context, listen: false);
    final webUrl = _getWebUrl(sayfa);

    return Stack(
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
            webPageState.setLoading(true); // Sayfa yüklenmeye başladığında durum güncelle
          },
          onLoadStop: (controller, url) async {
            await controller.evaluateJavascript(source: '''
              const bottomBar = document.querySelector('.bottom-bar');
                  if (bottomBar) {
                    bottomBar.setAttribute('style', 'display: none !important;'); // Stil ekle
                  }
              document.querySelector('header').style.display = 'none'; // Header'ı gizle
              document.querySelector('.breadcrumb-container').style.display = 'none'; // Breadcrumb'ı gizle
            ''');
            webPageState.setLoading(false); // Yükleme tamamlandığında durum güncelle
          },
        ),
        Consumer<WebPageState>(
          builder: (context, state, child) {
            return state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink(); // Yükleme tamamlanınca göstergeyi kaldır
          },
        ),
      ],
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
      default:
        return 'https://www.biruni.edu.tr'; // Varsayılan URL
    }
  }
}
