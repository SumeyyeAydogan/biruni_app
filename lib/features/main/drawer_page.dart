import 'package:biruni_app/core/extension/context_extension.dart';
import 'package:biruni_app/features/akademi/akademi_sayfasi.dart';
import 'package:biruni_app/features/iletisim/ileti%C5%9Fim_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../akademi/fakulteler/fakulte_page.dart';
import '../akademi/yayinlarimiz/yayinlarimiz_sayfasi.dart';
import '../home/anasayfa.dart';
import '../olanaklar/olanaklar_sayfasi.dart';
import '../universitemiz/universitemiz.dart';
import '../universitemiz/yonetim/yonetim_detay_sayfasi.dart';
import 'drawer_state.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  List<String> yonetimList = [
    'Mütevelli Heyeti',
    'Rektörlük',
    'Senato',
    'Üniversite Yönetim Kurulu',
    'Yönetimsel Şema'
  ];
  List<String> fakulteList = [
    'Diş Hekimliği Fakültesi',
    'Eczacılık Fakültesi',
    'Eğitim Fakültesi',
    'Mühendislik ve Doğa Bilimler Fakültesi',
    'Sağlık Bilimleri Fakültesi',
    'Tıp Fakültesi'
  ];
  List<String> akademiList = ['Etik Kurul', 'Lisansüstü Eğitim Enstitüsü', 'Meslek Yüksekokulu'];
  List<String> olanaklarList = ['Kütüphane', 'Yurtlar', 'Öğrenci Toplulukları'];
  List<String> rektorlugeBagliBolumlerList = ['Yabancı Diller Bölümü'];
  List<String> yayinlarList = [
    'Biruni Sağlık ve Eğitim Bilimleri Dergisi (BSEBD)',
    'Psycho-Educational Research Reviews (PERR)',
    'Bilimsel Yayınlar'
  ];
  @override
  Widget build(BuildContext context) {
    final drawerState = Provider.of<DrawerState>(context); // DrawerState'i erişiyoruz
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.person), // Hazır profil ikonu
            onPressed: () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UniversitemizSayfasi(sayfa: 'Öğrenci Portalı')),
          );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/biruni_logo.png",
                    ),
                    fit: BoxFit.fitHeight),
              ),
              child: SizedBox(),
            ),
            _buildSection('Üniversitemiz', [
              _buildTextButton('Tarihçe'),
              _buildTextButton('Misyon-Vizyon'),
              _buildInkwell("Yönetim", drawerState.toggleYonetim),
              if (drawerState.isYonetimOpen) ...yonetimList.map((yonetimElemani) => _buildTextButton(yonetimElemani)),
            ]),
            _buildSection('Akademi', [
              _buildInkwell("Fakülte", drawerState.toggleFakulte),
              if (drawerState.isFakulteOpen) ...fakulteList.map((fakulte) => _buildTextButton(fakulte)),
              ...akademiList.map((akademiSayfasi) => _buildTextButton(akademiSayfasi)),
              _buildInkwell("Rektörlüğe Bağlı Bölümler", drawerState.toggleRektorlukBolumleri),
              if (drawerState.isRektorlukBolumleriOpen)
                ...rektorlugeBagliBolumlerList.map((rektorlukBolumleri) => _buildTextButton(rektorlukBolumleri)),
              _buildInkwell("Yayınlarımız", drawerState.toggleYayinlarimiz),
              if (drawerState.isYayinlarimizOpen) ...yayinlarList.map((yayinlarimiz) => _buildTextButton(yayinlarimiz)),
            ]),
            _buildSection('Olanaklar', [
              ...olanaklarList.map((olanak) => _buildTextButton(olanak)),
            ]),
            _buildTextButton('Aday Öğrenci'),
            _buildSection('İletişim', [
              _buildTextButton('İletişim Bilgileri'),
            ]),
          ],
        ),
      ),
      body: const Anasayfa(),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextButton(String pageText) {
    Widget sayfa;
    if (pageText == "Tarihçe" || pageText == "Misyon-Vizyon" || pageText == "Aday Öğrenci") {
      sayfa = UniversitemizSayfasi(sayfa: pageText);
    } else if (yonetimList.contains(pageText)) {
      sayfa = YonetimDetaySayfasi(yonetimElemani: pageText);
    } else if (akademiList.contains(pageText) || rektorlugeBagliBolumlerList.contains(pageText)) {
      sayfa = AkademiSayfasi(sayfa: pageText);
    } else if (fakulteList.contains(pageText)) {
      sayfa = FakulteDetaySayfasi(fakulte: pageText);
    } else if (yayinlarList.contains(pageText)) {
      sayfa = YayinlarimizDetaySayfasi(yayin: pageText);
    } else if (olanaklarList.contains(pageText)) {
      sayfa = OlanaklarSayfasi(sayfa: pageText);
    } else if (pageText == "İletişim Bilgileri") {
      sayfa = IletisimSayfasi();
    } else {
      sayfa = const Anasayfa();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sayfa),
          );
        },
        child: Text(pageText),
      ),
    );
  }

  Widget _buildInkwell(String text, VoidCallback onTap) {
    return InkWell(
      // InkWell ile tıklanabilir hale getirme
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
