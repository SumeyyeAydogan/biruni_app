import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../product/constants/url_constants.dart';

class FakulteDetaySayfasi extends StatelessWidget {
  final String fakulte;

  const FakulteDetaySayfasi({Key? key, required this.fakulte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gelen yönetim elemanına göre web URL'i oluştur
    final webUrl = _getWebUrl(fakulte);

    // Web sayfasını çek ve görüntüle
    // (WebView veya InAppWebView kullanabilirsiniz)

    return Scaffold(
      appBar: AppBar(
        title: Text(fakulte),
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

  String _getWebUrl(String fakulte) {
    // Yönetim elemanına göre web URL'i oluşturma mantığı
    // Örneğin:
    switch (fakulte) {
      case 'Diş Hekimliği Fakültesi':
        return FakultelerUrlConstants.DIS;
      case 'Eczacılık Fakültesi':
        return FakultelerUrlConstants.ECZACILIK;
      case 'Eğitim Fakültesi':
        return FakultelerUrlConstants.EGITIM;
      case 'Mühendislik ve Doğa Bilimler Fakültesi':
        return FakultelerUrlConstants.MUHENDISLIK;
      case 'Sağlık Bilimleri Fakültesi':
        return FakultelerUrlConstants.SAGLIK_BILIMLERI;
      case 'Tıp Fakültesi':
        return FakultelerUrlConstants.TIP;
      default:
        return 'https://www.biruni.edu.tr'; // Varsayılan URL
    }
  }
}