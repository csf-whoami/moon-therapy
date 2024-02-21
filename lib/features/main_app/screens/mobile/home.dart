import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moon/core/helpers/actions_helper.dart';
import 'package:moon/core/theme.dart';
import 'package:moon/features/main_app/providers/therapy_provider.dart';
import 'package:moon/features/main_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String? title;
  const Home({Key? key, this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool dayAndNight = false;
  // DateTime _selectedDate = DateTime.now();
  // final _taskController = Get.put(Order());
  OrderProvider? np;

  var notifyHelper;

  @override
  void initState() {
    np = Provider.of<OrderProvider>(context, listen: false);
    np!.getAll();

    super.initState();
    // var tm = context.read<ThemeProvider>();
    // dayAndNight = tm.isDarkMode;

    // TODO: Setting notification
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile: ${widget.title!}"),
        actions: actionsMenu(context),
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTask(),
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
          // TODO: Button Create task.
          // MyButton(
          //     label: "+ Add Task",
          //     onPressed: () {
          //       // await Get.to(() => Order());
          //       // Nav.to(context, '/profile')
          //       Get.to(() => Order());
          //       _showTask();
          //     })
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
          np!.getAll();
          // _selectedDate = date;
        },
      ),
    );
  }

  Expanded _showTask() {
    return Expanded(
      child: Consumer<OrderProvider>(
        builder: (_, np, __) {
          if (np.isLoading == false) {
            return const Center(
              child: Text('News data loading....'),
            );
          } else if (np.orders != null) {
            var _orders = np.orders!;
            return ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) => Text('test'));
          } else {
            return const Center(
              child: Text('No news data fetched'),
            );
          }
        },
      ),
    );
  }
}
