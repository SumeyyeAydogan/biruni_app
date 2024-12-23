import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Anasayfa extends StatelessWidget {

  const Anasayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gelen yönetim elemanına göre web URL'i oluştur
    final webUrl = _getWebUrl();

    // Web sayfasını çek ve görüntüle
    // (WebView veya InAppWebView kullanabilirsiniz)

    return Scaffold(
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
          const bottomBar = document.querySelector('.bottom-bar');
                  if (bottomBar) {
                    bottomBar.setAttribute('style', 'display: none !important;'); // Stil ekle
                  }
              document.querySelector('header').style.display = 'none'; // Header'ı gizle
              document.querySelector('.breadcrumb-container').style.display = 'none'; // Breadcrumb'ı gizle
            ''');
        },
      ),
    );
  }

  String _getWebUrl() {
    // Yönetim elemanına göre web URL'i oluşturma mantığı
    // Örneğin:
    return 'https://www.biruni.edu.tr';
  }
}