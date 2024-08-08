import 'package:finance_expenses/HomePage/HomeView.dart';
import 'package:finance_expenses/Lateuse/color_extension.dart';
import 'package:finance_expenses/data/ExpenseData.dart';
import 'package:finance_expenses/models/expenseitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectTab = 0;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTab = Homeview();
  final newExpenseController = TextEditingController();
  final newAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          "Add New Expense",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newExpenseController,
                decoration: InputDecoration(
                  labelText: "Expense",
                  labelStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: newAmountController,
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              cancel();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: TColor.gray10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          TextButton(
            onPressed: () {
              save();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: TColor.gray60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void save() {
    Expenseitem newexpsense = Expenseitem(
        name: newExpenseController.text,
        amount: newAmountController.text,
        dateTime: DateTime.now());
    Provider.of<ExpenseData>(context, listen: false).addExpense(newexpsense);
  }

  void cancel() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        children: [
          PageStorage(bucket: pageStorageBucket, child: currentTab),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/img/bottom_bar_bg.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 0;
                                    currentTab = Homeview();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/home.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 0
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 1;
                                    currentTab = Homeview();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/budgets.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 1
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 2;
                                    currentTab = Homeview();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/calendar.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 2
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 3;
                                    currentTab = Homeview();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/creditcards.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 3
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () => addNewExpense(),
                        child: Container(
                          margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: TColor.secondary.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ], borderRadius: BorderRadius.circular(50)),
                          child: Image.asset("assets/img/center_btn.png",
                              height: 50, width: 50),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
