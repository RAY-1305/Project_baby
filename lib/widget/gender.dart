import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gender extends StatefulWidget {
  final bool gender;
  final Function(bool) onChanged;
  const Gender({super.key, required this.gender, required this.onChanged});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  var gender = true;
  @override
  void initState() {
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Giới tính',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: 120,
            height: 44,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        gender = true;
                      });
                      widget.onChanged(true);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                        color: gender
                            ? const Color.fromARGB(255, 244, 123, 19)
                            : Colors.white,
                      ),
                      child: Text(
                        'Nam',
                        style: GoogleFonts.getFont(
                          'Inter',
                          color: gender ? Colors.white : Colors.black,
                          fontWeight:
                              gender ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        gender = false;
                      });
                      widget.onChanged(false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                        color: !gender
                            ? const Color.fromARGB(255, 244, 123, 19)
                            : Colors.white,
                      ),
                      child: Text(
                        'Nữ',
                        style: GoogleFonts.getFont(
                          'Inter',
                          color: !gender ? Colors.white : Colors.black,
                          fontWeight:
                              !gender ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
