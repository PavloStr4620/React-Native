import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;


void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Облік витрат',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ExpensePage(),
    );
  }
}

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late Database db;
  List<Map<String, dynamic>> expenses = [];

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDB();
  }

  Future<void> _initDB() async {
    db = await openDatabase(
      p.join(await getDatabasesPath(), 'expenses.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount REAL, date TEXT)',
        );
      },
    );
    await _fetchExpenses();
  }

  Future<void> _addExpense(String title, double amount) async {
    final now = DateTime.now().toIso8601String();
    await db.insert('expenses', {
      'title': title,
      'amount': amount,
      'date': now,
    });
    await _fetchExpenses();
  }

  Future<void> _fetchExpenses() async {
    final data = await db.query('expenses', orderBy: 'date DESC');
    setState(() {
      expenses = data;
    });
  }

  Future<void> _deleteExpense(int id) async {
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
    await _fetchExpenses();
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Нова витрата'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Назва'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Сума'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final title = _titleController.text;
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              if (title.isNotEmpty && amount > 0) {
                _addExpense(title, amount);
              }
              _titleController.clear();
              _amountController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Додати'),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return '${date.day}.${date.month}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Облік витрат'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense['title']),
            subtitle: Text('₴${expense['amount']} — ${formatDate(expense['date'])}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteExpense(expense['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
