import 'package:flutter/material.dart';

import '../../product/widget/contact_info_row.dart';

class IletisimSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İletişim Bilgileri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContactInfoRow(
              icon: Icons.location_on,
              text: 'Merkezefendi Mahallesi G/75 Sk. No: 1-13\nZeytinburnu/İstanbul',
            ),
            const SizedBox(height: 16),
            ContactInfoRow(
              icon: Icons.phone,
              text: '444 8 276 (BRN)',
            ),
            const SizedBox(height: 16),
            ContactInfoRow(
              icon: Icons.print,
              text: '+90 212 416 46 46',
            ),
            const SizedBox(height: 16),
            ContactInfoRow(
              icon: Icons.email,
              text: 'biruniuniv@hs01.kep.tr',
            ),
            const SizedBox(height: 16),
            ContactInfoRow(
              icon: Icons.email_outlined,
              text: 'info@biruni.edu.tr',
            ),
            const SizedBox(height: 16),
            ContactInfoRow(
              icon: Icons.map,
              text: 'Haritada Görüntüle',
              isLink: true,
              onTap: () {
                // Harita bağlantısı için işlem eklenebilir
                print('Haritada Görüntüle tıklandı');
              },
            ),
          ],
        ),
      ),
    );
  }
}
