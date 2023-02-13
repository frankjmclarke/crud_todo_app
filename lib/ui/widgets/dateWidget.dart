import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({required this.label, required this.dateController, super.key});

  final TextEditingController dateController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 150,
      child: Center(
          child: TextField(
            controller: dateController,
            //editing controller of this TextField
            decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today),
                //icon of text field
                labelText: label, //label text of field
            ),
            readOnly: true,
            // when true user cannot edit text
            onTap: () async {
              final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  //get today's date
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101),);

              if (pickedDate != null) {
                print(
                    pickedDate,); //get the picked date in the format
                // => 2022-07-04 00:00:00.000
                final formattedDate = DateFormat('yyyy-MM-dd').format(
                    pickedDate,); // format date in required form here we use
                // yyyy-MM-dd that means time is removed
                print(
                    formattedDate,); //formatted date output using intl package
                // =>  2022-07-04
                //You can format date as per your need

                // was in setState
                dateController.text = formattedDate;
              } else {
                print('Date is not selected');
              }
            },
          ),),
    );
  }
}
