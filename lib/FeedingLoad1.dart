import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedingLoad extends StatefulWidget {
  const FeedingLoad({super.key});

  @override
  State<FeedingLoad> createState() => _FeedingLoadState();
}
class _FeedingLoadState extends State<FeedingLoad> {
  TextEditingController targetVolumeController = TextEditingController();
  TextEditingController dispensingTimeController = TextEditingController();
  TextEditingController viscosityController = TextEditingController();
  TextEditingController hoseSizeController = TextEditingController();
  TextEditingController hoseLengthController = TextEditingController();

  List<TableRow> resultTableRows = []; // 새로운 행을 추가하기 위한 리스트


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FEEDING LOAD CALUATOR', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                children: [
                  buildTableRow(['Parameter', 'Feeding']),
                  buildEditableTableRow('Target Volume', targetVolumeController, 'ml'),
                  buildEditableTableRow('Dispensing Time', dispensingTimeController, 'sec'),
                  buildEditableTableRow('Viscosity', viscosityController, 'mPa, cp'),
                  buildEditableTableRow('Hose size(inner)', hoseSizeController, 'cm'),
                  buildEditableTableRow('Hose length', hoseLengthController, 'm'),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  calculateFlowrate();
                },
                child: Text('계산하기', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              if (resultTableRows.isNotEmpty)
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(),
                  children: resultTableRows,
                ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow(List<String> cells) {
    return TableRow(
      children: cells
          .map((cell) => TableCell(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            cell,
            textAlign: TextAlign.center,
          ),
        ),
      ))
          .toList(),
    );
  }

  TableRow buildEditableTableRow(String parameter, TextEditingController controller, String unit) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              parameter,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
              ],
              decoration: InputDecoration(
                suffixText: unit,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void calculateFlowrate() {
    double targetVolume = double.tryParse(targetVolumeController.text) ?? 0.0;
    double dispensingTime = double.tryParse(dispensingTimeController.text) ?? 0.0;
    double viscosity = double.tryParse(viscosityController.text) ?? 0.0;
    double hoseSize = double.tryParse(hoseSizeController.text) ?? 0.0;
    double hoseLength = double.tryParse(hoseLengthController.text) ?? 0.0;

    if (targetVolume != 0 && dispensingTime != 0 && viscosity != 0 && hoseSize !=0 && hoseLength!=0) {
      double flowrate = targetVolume / dispensingTime;
      double flow = flowrate / (3.14 / 4 * pow(hoseSize, 2));
      double forceFeeding = viscosity / 1000 * 3.14 * hoseLength * 2 * flow / 100;
      double pressureFeeding = forceFeeding / (3.14 / 4 * pow(hoseSize, 2));

      String formattedFlow = flow.toStringAsFixed(3);
      String formattedForceFeeding = forceFeeding.toStringAsFixed(3);
      String formattedPressureFeeding = pressureFeeding.toStringAsFixed(3);

      setState(() {
        resultTableRows = [
          buildTableRow(['Velocity of flow (V)', '$formattedFlow cm/sec']),
          buildTableRow(['Force of feeding (Ft)', '$formattedForceFeeding kg']),
          buildTableRow(['Pressure of feeding (Pt)', '$formattedPressureFeeding bar']),
        ];
      });
    }
  }


}


