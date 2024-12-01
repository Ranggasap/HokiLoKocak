import 'package:flutter/material.dart';

class TableLeaderboardUI extends StatelessWidget {

  final List<Map<String, dynamic>> leaderboardData;

  const TableLeaderboardUI({required this.leaderboardData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Text(
          'LeaderBoard',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),

        // Table
        Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2), // Email
            1: FlexColumnWidth(1), // Win
            2: FlexColumnWidth(1), // Lose
            3: FlexColumnWidth(1), // Winrate
            4: FlexColumnWidth(1), // Rank
          },
          children: [
            // Table Header
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)))),
                TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Win', style: TextStyle(fontWeight: FontWeight.bold)))),
                TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Lose', style: TextStyle(fontWeight: FontWeight.bold)))),
                TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Winrate', style: TextStyle(fontWeight: FontWeight.bold)))),
                TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Rank', style: TextStyle(fontWeight: FontWeight.bold)))),
              ],
            ),
            // Dummy Data Rows
            ...leaderboardData.map(
                  (row) => TableRow(
                children: [
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row['email'] ?? "Unknown"))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row['win'].toString() ?? "Unknown"))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row['lose'].toString() ?? "Unknown"))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row['winrate'] ?? "Unknown"))),
                  TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row['rank'] ?? "Unknown"))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
