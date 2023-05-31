import 'package:flutter/material.dart';

class MaCarte extends StatefulWidget {
  const MaCarte({super.key});

  @override
  State<MaCarte> createState() => _MaCarteState();
}

class _MaCarteState extends State<MaCarte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: nomPrenom.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              borderOnForeground: true,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        images[index],
                      ),
                    ),
                    title: Text(nomPrenom[index],
                        style: const TextStyle(color: Colors.green)),
                    subtitle: Text(
                      phoneNumber[index],
                      style: const TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Icon(Icons.call),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Icon(Icons.mail),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, index) => const Divider()),
    );
  }

  final List nomPrenom = [
    'Yassine Bounou',
    'Youssef En-Nesyri',
    'Achraf Hakimi',
    'Hakim Ziyech',
  ];
  final List phoneNumber = [
    '11111111',
    '22222222',
    '33333333',
    '44444444',
  ];
  final List images = [
    'images/yassine-bounou.webp',
    'images/youssef-en-nesyri.webp',
    'images/achraf-hakimi.jfif',
    'images/hakim_ziyech.jpg',
  ];
}
