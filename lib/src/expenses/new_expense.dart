import 'package:flutter/material.dart';

import '../utils/ansi_colors_debug.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _ammountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _ammountController.dispose();
    super.dispose();
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
          TextField(
            controller: _ammountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '\$ ', // 접두문자
              // labelText: 'Amount',
              label: Text('Amount'),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
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
