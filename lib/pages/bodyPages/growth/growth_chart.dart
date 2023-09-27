import 'package:baby/models/growth/growth_info.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class GrowthChartWidget extends StatelessWidget {
  final List<GrowthInforRecord> records;

  const GrowthChartWidget({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    // Tạo danh sách các điểm dữ liệu cho biểu đồ cân nặng và chiều cao
    final List<FlSpot> weightSpots = [];
    final List<FlSpot> heightSpots = [];

    for (int i = 0; i < records.length; i++) {
      final record = records[i];
      // Sử dụng i làm giá trị x (thời gian) và record.weight và record.height là giá trị y tương ứng
      weightSpots.add(FlSpot(i.toDouble(), record.weight));
      heightSpots.add(FlSpot(i.toDouble(), record.height));
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            left: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        minX: 0,
        maxX: records.length.toDouble() - 1,
        minY: 0,
        maxY: _calculateMaxY(records),
        lineBarsData: [
          LineChartBarData(
            spots: weightSpots,
            isCurved: true,
            color: Colors.blue,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: heightSpots,
            isCurved: true,
            color: Colors.red,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }

  double _calculateMaxY(List<GrowthInforRecord> records) {
    double maxWeight = 0;
    double maxHeight = 0;

    for (final record in records) {
      if (record.weight > maxWeight) {
        maxWeight = record.weight;
      }
      if (record.height > maxHeight) {
        maxHeight = record.height;
      }
    }

    return maxWeight > maxHeight ? maxWeight : maxHeight;
  }
}
