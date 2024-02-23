import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moon/core/helpers/actions_helper.dart';
import 'package:moon/core/theme.dart';
import 'package:moon/features/lead_mod/models/models.dart';
import 'package:moon/features/main_app/providers/therapy_provider.dart';
import 'package:moon/features/main_app/screens/mobile/task_title.dart';
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
              itemBuilder: (_, index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(_orders[index]);
                              },
                              child: TaskTile(_orders[index]),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            );
          } else {
            return const Center(
              child: Text('No news data fetched'),
            );
          }
        },
      ),
    );
  }

  // Show popup at button.
  _showBottomSheet(OrderDataResponse task) {
    // Show button slide.
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.only(top: 4),
              height: task.isCompleted == 1
                  ? MediaQuery.of(context).size.height * 0.24
                  : MediaQuery.of(context).size.height * 0.32,
              // color: Get.isDarkMode ? darkGreyClr : Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 6,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Get.isDarkMode
                            ? Colors.grey[600]
                            : Colors.grey[300]),
                  ),
                  Spacer(),
                  task.isCompleted == 2
                      ? Container()
                      : _bottomSheetButton(
                          label: "Task completed",
                          onTap: () {
                            print("Tab in Task completed.");
                            Navigator.pop(context);
                          },
                          clr: primaryClr,
                          context: context,
                          isClose: true),
                  SizedBox(
                    height: 20,
                  ),
                  _bottomSheetButton(
                      label: "Delete Task",
                      onTap: () {
                        print("Tab in Delete Task.");
                        Navigator.pop(context);
                      },
                      clr: Colors.red[300]!,
                      context: context,
                      isClose: true),
                ],
              ),
            )
        // const FlutterLogo(size: 400),
        );
  }

  _bottomSheetButton(
      {required String label,
      required VoidCallback onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width,
        // color: isClose == true ? Colors.red : Colors.yellow,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true ? Colors.red : Colors.yellow,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.red : Colors.yellow,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.red,
                  ),
          ),
        ),
      ),
    );
  }
}
