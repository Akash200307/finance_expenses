import 'package:finance_expenses/Lateuse/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/ExpenseData.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: TColor.gray,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.width * 1.0,
                decoration: BoxDecoration(
                  color: TColor.gray40.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                // Optionally add content here to debug visibility
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: value.getExpenseList().isEmpty
                    ? const Center(child: Text("No expenses yet"))
                    : ListView.builder(
                        itemCount: value.getExpenseList().length,
                        itemBuilder: (context, index) {
                          final expense = value.getExpenseList()[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: TColor.gray60.withOpacity(0.2),
                              border: Border.all(
                                  color: TColor.border.withOpacity(0.15)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    style: TextStyle(
                                        color: TColor.gray10, fontSize: 16),
                                    expense.name),
                              ),
                              trailing: Text(
                                  style: TextStyle(
                                      color: Colors.greenAccent, fontSize: 16),
                                  '\$${expense.amount}'),
                            ),
                            margin: const EdgeInsets.all(8),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
