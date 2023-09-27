import 'package:baby/models/growth/growth_info.dart';
import 'package:baby/provider/growth_infor_provider.dart';
import 'package:baby/widget/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class InfoRecordDetail extends StatefulWidget {
  final double? width;
  final double? height;
  final int? index; // Thêm index để biết là đang sửa record nào
  const InfoRecordDetail({super.key, this.width, this.height, this.index});

  @override
  State<InfoRecordDetail> createState() => _InfoRecordDetailState();
}

class _InfoRecordDetailState extends State<InfoRecordDetail> {
  //textcontroller
  TextEditingController timeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //chọn ngày
  DateTime selectedDate = DateTime.now();

  //update timeController
  void updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      // Nếu đang sửa thì điền thông tin cũ vào các controller
      final provider = Provider.of<GrowthInforProvider>(context, listen: false);
      final record = provider.records[widget.index!];
      selectedDate = record.time;
      timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      weightController.text = record.weight.toString();
      heightController.text = record.height.toString();
      noteController.text = record.note ?? '';
    } else {
      // Nếu thêm mới thì khởi tạo giá trị ban đầu
      weightController.text = "0";
      heightController.text = "0";
      timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    super.initState();
  }

  void saveRecord() {
    final provider = Provider.of<GrowthInforProvider>(context, listen: false);
    final record = GrowthInforRecord(
      time: selectedDate,
      weight: double.parse(weightController.text),
      height: double.parse(heightController.text),
      note: noteController.text.isEmpty ? null : noteController.text,
    );

    if (widget.index != null) {
      // Nếu đang sửa thì cập nhật record cũ
      provider.editRecord(widget.index!, record);
    } else {
      // Nếu thêm mới thì thêm record mới
      provider.addRecord(record);
    }

    Navigator.pop(context);
  }

  void deleteRecord() {
    final provider = Provider.of<GrowthInforProvider>(context, listen: false);
    provider.deleteRecord(widget.index!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index != null ? "Chỉnh sửa thông tin" : "Thêm thông tin",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height / 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tăng trưởng",
                      style: GoogleFonts.getFont("Inter",
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Tuổi: 5th (tuần 22)",
                      style: GoogleFonts.getFont("Inter",
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Hiển thị hộp thoại cảnh báo khi người dùng nhấn vào nút
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Xác nhận xoá"),
                                content: const Text(
                                    "Bạn có chắc chắn muốn xoá thông tin này?"),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: Colors
                                              .blue, // Màu nền của nút "Huỷ"
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pop(); // Đóng hộp thoại
                                            },
                                            child: const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              16), // Khoảng cách giữa hai nút
                                      ClipOval(
                                        child: Material(
                                          color: Colors
                                              .red, // Màu nền của nút "Xoá"
                                          child: InkWell(
                                            onTap: () {
                                              // Gọi hàm để xoá thông tin
                                              deleteRecord();
                                              Navigator.of(context)
                                                  .pop(); // Đóng hộp thoại
                                            },
                                            child: const SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(MdiIcons.delete),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 244, 244),
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  //thời gian
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.calendarClock),
                      const SizedBox(width: 16),
                      Text(
                        "Thời gian",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            showDatePickerPopupIos(
                                context, selectedDate, updateSelectedDate);
                          },
                          controller: timeController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  // cân nặng
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.scale),
                      const SizedBox(width: 16),
                      Text(
                        "Cân nặng",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9.]')), // Chấp nhận số và dấu chấm (cho trường hợp nhập số thập phân)
                          ],
                          onChanged: (value) {
                            // Xử lý giá trị nhập vào
                            if (value.startsWith('0')) {
                              // Nếu giá trị bắt đầu bằng 0, loại bỏ 0 và cập nhật giá trị vào TextField
                              weightController.text =
                                  int.parse(value).toString();
                            }
                          },
                          controller: weightController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "kg",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  //chiều cao
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.humanMaleHeight),
                      const SizedBox(width: 16),
                      Text(
                        "Chiều cao",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          keyboardType:
                              TextInputType.number, // Chọn kiểu bàn phím số
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9.]')), // Chấp nhận số và dấu chấm (cho trường hợp nhập số thập phân)
                          ],
                          onChanged: (value) {
                            // Xử lý giá trị nhập vào
                            if (value.startsWith('0')) {
                              // Nếu giá trị bắt đầu bằng 0, loại bỏ 0 và cập nhật giá trị vào TextField
                              heightController.text =
                                  int.parse(value).toString();
                            }
                          },
                          controller: heightController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "cm",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ghi chú
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.notebookEditOutline),
                      const SizedBox(width: 16),
                      Text(
                        "Ghi chú:",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: noteController,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height / 10,
            ),
            GestureDetector(
              onTap: saveRecord,
              child: Container(
                height: screenSize.height / 16,
                width: screenSize.width - 144,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 123, 19),
                  borderRadius: BorderRadius.circular(screenSize.height / 16),
                ),
                child: Center(
                  child: Text(
                    widget.index != null
                        ? "Chỉnh sửa thông tin"
                        : "Thêm thông tin",
                    style: GoogleFonts.getFont("Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
