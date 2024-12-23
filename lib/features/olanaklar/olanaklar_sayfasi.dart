import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../product/constants/url_constants.dart';

class OlanaklarSayfasi extends StatelessWidget {
  final String sayfa;
  const OlanaklarSayfasi({Key? key, required this.sayfa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webUrl = _getWebUrl(sayfa);
    return Scaffold(
      appBar: AppBar(
        title: Text(sayfa),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(Uri.parse(webUrl)),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;

          if (uri.toString().startsWith('https://www.biruni.edu.tr/uygulama-ve-arastirma-merkezleri/')) {
            // İstenmeyen URL'yi engelle
            return NavigationActionPolicy.CANCEL;
          } else {
            // Diğer URL'lere izin ver
            return NavigationActionPolicy.ALLOW;
          }
        },
        onLoadStop: (controller, url) async {
          // Web sayfası yüklendiğinde çalıştırılacak JavaScript kodu
          await controller.evaluateJavascript(source: '''
    // Üst kısmı gizle
    document.querySelector('header').style.display = 'none'; // Header'ı gizler
    document.querySelector('.breadcrumb-container').style.display = 'none'; // Breadcrumb'ı gizler
    document.querySelector('footer').style.display = 'none'; // Footer'ı gizler
    document.querySelectorAll('.some-other-selector').forEach(el => el.style.display = 'none'); // Gerekirse başka elemanları gizle
  ''');
        },
      ),
    );
  }
}

String _getWebUrl(String sayfa) {
  // Yönetim elemanına göre web URL'i oluşturma mantığı
  // Örneğin:
  switch (sayfa) {
    case 'Kütüphane':
      return OlanaklarUrlConstants.KUTUPHANE;
    case 'Yurtlar':
      return OlanaklarUrlConstants.YURTLAR;
    case 'Öğrenci Toplulukları':
      return OlanaklarUrlConstants.TOPLULUKLAR;
    default:
      return 'https://www.biruni.edu.tr'; // Varsayılan URL
  }
}
