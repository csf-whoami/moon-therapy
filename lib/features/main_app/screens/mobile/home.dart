import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moon/core/theme.dart';
import 'package:moon/core/widgets/myButton.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';

class Home extends StatefulWidget {
  final String? title;
  const Home({Key? key, this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool dayAndNight = false;

  DateTime _selectedDate = DateTime.now();
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    var tm = context.read<ThemeProvider>();
    dayAndNight = tm.isDarkMode;

    // TODO: Setting notification
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    // var tm = context.read<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile: ${widget.title!}"),
        actions: actionsMenu(context),
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () => {
                    // Get.to(AddTaskPage())
                    Nav.to(context, '/profile')
                  })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }
}
