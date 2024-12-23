import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../product/constants/url_constants.dart';

class YonetimDetaySayfasi extends StatelessWidget {
  final String yonetimElemani;

  const YonetimDetaySayfasi({Key? key, required this.yonetimElemani}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gelen yönetim elemanına göre web URL'i oluştur
    final webUrl = _getWebUrl(yonetimElemani);

    // Web sayfasını çek ve görüntüle
    // (WebView veya InAppWebView kullanabilirsiniz)

    return Scaffold(
      appBar: AppBar(
        title: Text(yonetimElemani),
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
    document.querySelector('.bottom-bar').style.display = 'none';
  ''');
        },
      ),
    );
  }

  String _getWebUrl(String yonetimElemani) {
    // Yönetim elemanına göre web URL'i oluşturma mantığı
    // Örneğin:
    switch (yonetimElemani) {
      case 'Mütevelli Heyeti':
        return YonetimUrlConstants.MUTEVELLI_HEYETI;
      case 'Rektörlük':
        return YonetimUrlConstants.REKTORLUK;
      case 'Senato':
        return YonetimUrlConstants.SENATO;
      case 'Üniversite Yönetim Kurulu':
        return YonetimUrlConstants.YONETIM_KURULU;
      case 'Yönetimsel Şema':
        return YonetimUrlConstants.YONETIMSEL_SEMA;
      default:
        return 'https://www.biruni.edu.tr'; // Varsayılan URL
    }
  }
}