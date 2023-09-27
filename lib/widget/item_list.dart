import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemListWg extends StatelessWidget {
  final int id;
  final String name;
  final double width;
  final IconData? icon;

  const ItemListWg(
      {super.key,
      required this.id,
      required this.name,
      required this.width,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(100, 255, 245, 210),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 30,
                  color: Colors.blue,
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CHƯƠNG $id",
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 16,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
