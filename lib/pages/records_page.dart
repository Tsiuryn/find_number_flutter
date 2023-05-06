import 'package:collection/collection.dart';
import 'package:find_number/app/config/config.dart';
import 'package:find_number/app/config/records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/game_loc.dart';

class RecordsPage extends StatefulWidget {
  final Config config;
  final Records records;

  const RecordsPage({
    Key? key,
    required this.records,
    required this.config,
  }) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  late Records _appRecords;

  @override
  void initState() {
    super.initState();
    _appRecords = widget.records;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final noRecords = _appRecords.records.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.records__appbar_title),
      ),
      body: noRecords
          ? Center(
              child: Text(l10n.records__no_records),
            )
          : AppDataTable(
              records: _appRecords.records,
              onClearHistory: clearRecords,
            ),
    );
  }

  void clearRecords() {
    widget.config.clearRecords();
    setState(() {
      _appRecords = Records.empty();
    });
  }
}

class AppDataTable extends StatefulWidget {
  final List<AppRecord> records;
  final VoidCallback onClearHistory;

  const AppDataTable({
    Key? key,
    required this.records,
    required this.onClearHistory,
  }) : super(key: key);

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  List<DataColumn> columns = const [
    DataColumn(label: Center(child: Text('N'))),
    DataColumn(label: Center(child: Text('Дата'))),
    DataColumn(label: Center(child: Text('Количество колонок, шт'))),
    DataColumn(label: Center(child: Text('Количество строк, шт'))),
    DataColumn(label: Center(child: Text('Время прохождения, сек'))),
  ];

  late List<DataRow> rows;

  @override
  void initState() {
    super.initState();
    rows = widget.records.reversed
        .mapIndexed((index, value) => DataRow(cells: getCells(value, index)))
        .toList();
  }

  List<DataCell> getCells(
    AppRecord appRecord,
    int index,
  ) {
    return [
      DataCell(Center(child: Text((index + 1).toString()))),
      DataCell(Center(child: Text(appRecord.date))),
      DataCell(Center(
          child: Text(
        appRecord.countViewsInHor.toString(),
      ))),
      DataCell(Center(child: Text(appRecord.countViewsInVer.toString()))),
      DataCell(Center(child: Text(appRecord.seconds.toString()))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      DataTable(
                        columns: columns,
                        rows: rows,
                        border: TableBorder.all(color: Colors.black12),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: widget.onClearHistory,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white, //<-- SEE HERE
          ),
          child: const Text('Стереть историю'),
        )
      ],
    );
  }
}
