
import 'package:baby/models/hanbook/safety_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafetyContent extends StatelessWidget {
  final SafetyDatum safetyDatum;
  const SafetyContent({super.key, required this.safetyDatum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          safetyDatum.name,
          style: GoogleFonts.getFont(
            'Roboto',
            fontSize: 18,
          ),
        ),backgroundColor: const Color.fromARGB(100, 255, 245, 210),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: safetyDatum.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (safetyDatum.data[index].contentName != "")
                  Text(
                    safetyDatum.data[index].contentName,
                    style: GoogleFonts.getFont('Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                if (safetyDatum.data[index].contentName != "")
                  const SizedBox(height: 8),
                if (safetyDatum.data[index].content != "")
                  Text(
                    safetyDatum.data[index].content,
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      //color: Colors.blue),
                    ),
                  ),
                if (safetyDatum.data[index].content != "")
                  const SizedBox(height: 8),
                if (safetyDatum.data[index].image != null)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: safetyDatum.data[index].image ?? "",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (safetyDatum.data[index].image != null)
                  const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
