import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../product/constants/url_constants.dart';

class AkademiSayfasi extends StatelessWidget {
  final String sayfa;
  const AkademiSayfasi({Key? key, required this.sayfa}) : super(key: key);

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
}

String _getWebUrl(String sayfa) {
  // Yönetim elemanına göre web URL'i oluşturma mantığı
  // Örneğin:
  switch (sayfa) {
    case 'Etik Kurul':
      return AkademiUrlConstants.ETIK_KURUL;
    case 'Lisansüstü Eğitim Enstitüsü':
      return AkademiUrlConstants.LISANSUSTU;
    case 'Meslek Yüksekokulu':
      return AkademiUrlConstants.MESLEK_YUKSEKOKULU;
    case 'Yabancı Diller Bölümü':
      return AkademiUrlConstants.YABANCI_DILLER;  
    // ... diğer yönetim elemanları için URL'ler ...
    default:
      return 'https://www.biruni.edu.tr'; // Varsayılan URL
  }
}
