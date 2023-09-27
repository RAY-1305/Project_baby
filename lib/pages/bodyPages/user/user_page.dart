import 'package:baby/pages/bodyPages/user/parent_profile.dart';
import 'package:baby/provider/parent_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // Truy xuất thông tin từ ParentProvider
    final parentProvider = Provider.of<ParentProvider>(context);

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Text(
          "Thông tin người dùng",
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //thông tin người dùng
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Giới thiệu",
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ParentProfile(),
                              ),
                            );
                          },
                          child: Text(
                            "cập nhật",
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
                    //tên người dùng
                    Row(
                      children: [
                        Icon(MdiIcons.cardAccountDetailsOutline, size: 16),
                        const SizedBox(width: 16),
                        Text(
                          (parentProvider.parent!.name == null ||
                                  parentProvider.parent!.name == "")
                              ? "Người dùng"
                              : parentProvider.parent!.name ?? "Người dùng",
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    //mail
                    Row(
                      children: [
                        Icon(MdiIcons.emailOutline, size: 16),
                        const SizedBox(width: 16),
                        Text(
                          parentProvider.parent!.email,
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    //ghi chú
                    if (parentProvider.parent!.phone != null &&
                        parentProvider.parent!.phone != "")
                      Row(
                        children: [
                          Icon(MdiIcons.cellphone, size: 16),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              parentProvider.parent!.phone!,
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
            ],
          ),
          const SizedBox(height: 16),

          //thông tin bé
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Các bé",
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "thêm bé",
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
                    //tên người dùng
                    Row(
                      children: [
                        Icon(MdiIcons.cardAccountDetailsOutline, size: 16),
                        const SizedBox(width: 16),
                        Text(
                          "Tên bé",
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    //mail
                    Row(
                      children: [
                        Icon(MdiIcons.emailOutline, size: 16),
                        const SizedBox(width: 16),
                        Text(
                          "mail",
                          style: GoogleFonts.getFont(
                            'Inter',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    //ghi chú

                    Row(
                      children: [
                        Icon(MdiIcons.cellphone, size: 16),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "điện thoại",
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
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
