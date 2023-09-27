// ignore_for_file: avoid_print

import 'package:baby/pages/bodyPages/growth/record_detail.dart';
import 'package:baby/provider/growth_infor_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GrowthInforListPage extends StatefulWidget {
  const GrowthInforListPage({super.key});

  @override
  State<GrowthInforListPage> createState() => _GrowthInforListPageState();
}

class _GrowthInforListPageState extends State<GrowthInforListPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GrowthInforProvider>(context);
    final records = provider.records;
    print("độ dài records: ${records.length}");
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin tăng trưởng",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        // color: Colors.red,
        width: screenSize.width,
        child: Column(
          children: [
            SizedBox(height: screenSize.height / 20),
            (records.isEmpty)
                ? Center(
                    child: Text(
                      "Chưa có thông tin.\nVui lòng thêm thông tin",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final growthInfo = records[index];
                        return GestureDetector(
                          onTap: () {
                            // Xử lý khi người dùng nhấn vào một bản ghi cụ thể (nếu cần)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoRecordDetail(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //thời gian
                              Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Text(
                                    DateFormat("dd/MM/yyyy")
                                        .format(growthInfo.time),
                                    style: GoogleFonts.getFont(
                                      'Inter',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: screenSize.width,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 244, 244),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //tính tuổi tự động
                                    Text(
                                      "Tuổi: 1n 6th",
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    //cân nặng
                                    Row(
                                      children: [
                                        Icon(MdiIcons.scale, size: 16),
                                        const SizedBox(width: 16),
                                        Text(
                                          "Cân nặng: ${growthInfo.weight} kg",
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    //chiều cao
                                    Row(
                                      children: [
                                        Icon(MdiIcons.humanMaleHeight,
                                            size: 16),
                                        const SizedBox(width: 16),
                                        Text(
                                          "Chiều cao: ${growthInfo.height} cm",
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    //ghi chú
                                    if (growthInfo.note != null)
                                      Row(
                                        children: [
                                          Icon(MdiIcons.notebookEditOutline,
                                              size: 16),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              "Ghi chú: ${growthInfo.note}",
                                              style: GoogleFonts.getFont(
                                                'Inter',
                                                fontSize: 14,
                                              ),
                                              softWrap: true,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Thêm mới",
        backgroundColor: const Color.fromARGB(255, 244, 123, 19),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InfoRecordDetail(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
