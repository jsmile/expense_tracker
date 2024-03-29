import 'package:flutter/material.dart';

import '../utils/ansi_colors_debug.dart';
import './model/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

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

  void _submitExpenseData() {
    final isEmptyTitle = _titleController.text.trim().isEmpty;
    final isNullDate = _selectedDate == null;
    // double.tryParse( 'hello' ) --> null, double.tryParse( '12.3' ) --> 12.3
    final enteredAmmount = double.tryParse(_ammountController.text);
    final isInvaliedAmount = (enteredAmmount == null || enteredAmmount <= 0);

    if (isEmptyTitle || isNullDate || isInvaliedAmount) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Alert Dialog'),
          content: const Text(
              'Please make sure valid title, date, amount, and category were entered. '),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      );

      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: enteredAmmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // When a mobile device's keyboard is visible viewInsets.bottom corresponds to the top of the keyboard.
    final swKeyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity, // 가능한 한 최고의 높이
          // 스크롤 가능한 위젯
          child: SingleChildScrollView(
            child: Padding(
              // padding: const EdgeInsets.all(16.0),
              padding: EdgeInsets.only(
                  top: 16.0,
                  // 맨 아래 패딩이 보일 때 키보드 높이와 동일하게 되어 키보드가 위젯을 가리는 것을 방지.
                  bottom: swKeyboardSpace + 16.0,
                  left: 16.0,
                  right: 16.0),
              // padding: EdgeInsets.fromLTRB(
              //   16.0,
              //   16.0,
              //   16.0,
              //   MediaQuery.of(context).viewInsets.bottom,
              // ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  if (width <= 600) ...under600Width() else ...over600Width(),

                  // TextField(
                  //   controller: _titleController,
                  //   maxLength: 50,
                  //   decoration: const InputDecoration(
                  //     // labelText: 'Title',
                  //     label: Text('Title'),
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       // Row 하위의 InputDecoration 과 관련된 error 방지.
                  //       child: TextField(
                  //         controller: _ammountController,
                  //         keyboardType: TextInputType.number,
                  //         decoration: const InputDecoration(
                  //           prefixText: '\$ ', // 접두문자
                  //           // labelText: 'Amount',
                  //           label: Text('Amount'),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 16.0,
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(_selectedDate == null
                  //             ? 'No Date Selected'
                  //             : dateFormat.format(_selectedDate!)),
                  //         IconButton(
                  //           onPressed: _presentDatePicker,
                  //           icon: const Icon(Icons.calendar_month),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(height: 30.0),
                  // Row(
                  //   children: [
                  //     DropdownButton(
                  //       value: _selectedCategory, // displayed & selected value
                  //       // iterable --> list 로 변환
                  //       items: Category.values
                  //           .map(
                  //             (category) => DropdownMenuItem(
                  //               value: category, // inner value
                  //               child: Text(category.name.toUpperCase()),
                  //             ),
                  //           )
                  //           .toList(), // iterable --> list 로 변환
                  //       onChanged: (value) {
                  //         if (value == null) return;
                  //         setState(() {
                  //           _selectedCategory = value;
                  //         });
                  //       },
                  //     ),
                  //     const Spacer(),
                  //     TextButton(
                  //       onPressed: () {
                  //         Navigator.pop(context); // context 를 제거함.
                  //       },
                  //       child: const Text('Cancel'),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: _submitExpenseData,
                  //       child: const Text('Save Expense'),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> under600Width() {
    return [
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
            // Row 하위의 InputDecoration 과 관련된 error 방지.
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
                .toList(), // iterable --> list 로 변환
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
            onPressed: _submitExpenseData,
            child: const Text('Save Expense'),
          ),
        ],
      )
    ];
  }

  List<Widget> over600Width() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                // labelText: 'Title',
                label: Text('Title'),
              ),
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            // Row 하위의 InputDecoration 과 관련된 error 방지.
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
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                .toList(), // iterable --> list 로 변환
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Row(
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
            ),
          ),
        ],
      ),
      Row(
        children: [
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // context 를 제거함.
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitExpenseData,
            child: const Text('Save Expense'),
          ),
        ],
      ),
    ];
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
