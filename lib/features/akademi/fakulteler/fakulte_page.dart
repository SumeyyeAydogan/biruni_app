import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/webpage_state.dart';
import '../../../product/constants/url_constants.dart';

class FakulteDetaySayfasi extends StatelessWidget {
  final String fakulte;
  const FakulteDetaySayfasi({Key? key, required this.fakulte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webPageState = Provider.of<WebPageState>(context, listen: false);
    final webUrl = _getWebUrl(fakulte);

    return Scaffold(
      appBar: AppBar(
        title: Text(fakulte),
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

  String _getWebUrl(String fakulte) {
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
        return 'https://www.biruni.edu.tr';
    }
  }
}
