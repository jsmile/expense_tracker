import 'package:flutter/material.dart';

import '../utils/ansi_colors_debug.dart';
import './model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _ammountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _ammountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    // 1년전 --> firstDate 와 lastDate( now ) 간의 간격을 1년으로 설정하기 위함.
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    // showDatePicker(
    //   context: context,
    //   initialDate: now,
    //   firstDate: firstDate,
    //   lastDate: now,
    // ).then((value) => ...);

    // 선택된 날짜가 화면에 보이도록 함.
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              // labelText: 'Title',
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ammountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ', // 접두문자
                    // labelText: 'Amount',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Selected'
                      : dateFormat.format(_selectedDate!)),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 30.0),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory, // displayed & selected value
                // iterable --> list 로 변환
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category, // inner value
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // context 를 제거함.
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint(success('### ${_titleController.text}'));
                },
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class _NewExpenseState extends State<NewExpense> {
//   String _enteredTitle = '';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           TextField(
//             onChanged: (inputValue) {
//               _enteredTitle = inputValue;
//             },
//             maxLength: 50,
//             decoration: const InputDecoration(
//               labelText: 'Title',
//             ),
//           ),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   debugPrint(success('### $_enteredTitle'));
//                 },
//                 child: const Text('Save Expense'),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
