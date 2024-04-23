import 'package:flutter/material.dart';

class InvestmentCard extends StatelessWidget {
  final String stageTitle;
  final String minimumInvestment;
  final String tokenPrice;
  final String status;

  InvestmentCard({
    required this.stageTitle,
    required this.minimumInvestment,
    required this.tokenPrice,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: status == 'Open' ? Colors.green : Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stageTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Minimum Investment: $minimumInvestment',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            'Token Price: $tokenPrice',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text(
            'Status: $status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: status == 'Open' ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}