import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:moon/architect.dart';
import 'package:moon/core/core.dart';
import 'package:moon/core/theme.dart';
import 'package:moon/core/widgets/input_field.dart';
import 'package:moon/features/main_app/providers/therapy_provider.dart';
import 'package:moon/features/main_app/widgets/myButton.dart';
import 'package:substring_highlight/substring_highlight.dart';

// ignore: must_be_immutable
class Order extends StatefulWidget {
  final String? title;

  const Order({Key? key, this.title}) : super(key: key);

  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<Order> {
  final OrderProvider _orderProvider = OrderProvider();

  late String _requester;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _jobType = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  List<int> remindList = [5, 10, 15, 20];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColor = 0;
  bool isLoading = false;
  late List<String> autoCompleteData;
  late TextEditingController _controller;
  bool isExpanse = false;

  final List<String> options = ["Active", "NotActive"];
  late String currentOption = options[0];

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    // TODO
    final String stringData = await rootBundle.loadString("assets/data.json");
    final List<dynamic> json = jsonDecode(stringData);
    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(title!),
        actions: actionsMenu(context),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tạo thông tin yêu cầu trị liệu", style: subTitleStyle),
              // TODO: Chỉnh lại thành Common component giống như button.
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tìm kiếm thông tin...", style: subTitleStyle),
                    Autocomplete(
                      optionsBuilder: (TextEditingValue _textEditingValue) {
                        if (_textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        } else {
                          return autoCompleteData.where((word) =>
                              word.toLowerCase().contains(_textEditingValue.text.toLowerCase()));
                        }
                      },
                      // Display style for Results
                      optionsViewBuilder: (context, Function(String) onSelected, options) {
                        return Material(
                            elevation: 4,
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final option = options.elementAt(index);
                                  return ListTile(
                                    title: SubstringHighlight(
                                      text: option.toString(),
                                      term: _controller.text,
                                      textStyleHighlight: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          backgroundColor: Colors.yellow,
                                          color: primaryClr),
                                    ),
                                    subtitle: Text("This is subtitle"),
                                    onTap: () {
                                      onSelected(option.toString());
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: options.length));
                      },
                      onSelected: (selectString) {
                        print("Select $selectString");
                      }, // TODO: Callback method
                      fieldViewBuilder: // Style view
                          (context, controller, focusNode, onEditingComplete) {
                        this._controller = controller;

                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey[300]!)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey[300]!)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey[300]!)),
                            hintText: "Tên người yêu cầu...",
                            prefixIcon: Icon(Icons.account_circle_sharp),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => print("Click to button Clear."),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // TODO: Group thông tin cá nhân.
              Container(
                margin: EdgeInsets.only(top: 30),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Thông tin cá nhân',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyInputField(
                        title: "Họ tên",
                        hint: "Họ và tên...",
                        controller: _fullName,
                      ),
                      MyInputField(
                        title: "Số điện thoại",
                        hint: "Số điện thoại...",
                        controller: _phoneNo,
                      ),
                      MyInputField(
                        title: "Địa chỉ",
                        hint: "Địa chỉ...",
                        controller: _address,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isExpanse = !isExpanse;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(isExpanse == false ? "Thông tin thêm" : "Thu gọn"), // <-- Text
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                isExpanse == false
                                    ? Icons.arrow_drop_down_sharp
                                    : Icons.arrow_drop_up_sharp,
                                size: 36.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: isExpanse == false
                            ? Container()
                            : Column(
                                children: [
                                  MyInputField(
                                    title: "Nghề nghiệp",
                                    hint: "Nghề nghiệp hiện tại...",
                                    controller: _jobType,
                                  ),
                                  MyInputField(
                                    title: "Chiều cao",
                                    hint: "Chiều cao (cm)...",
                                    controller: _height,
                                  ),
                                  MyInputField(
                                    title: "Cân nặng",
                                    hint: "Cân nặng (kg)...",
                                    controller: _weight,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // TODO: Thông tin đăng ký trị liệu.
              Container(
                margin: EdgeInsets.only(top: 30),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Thông tin trị liệu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text("Ngày xác định"),
                              leading: Radio(
                                value: options[0],
                                groupValue: currentOption,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text("Chưa xác định ngày"),
                              leading: Radio(
                                value: options[1],
                                groupValue: currentOption,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      currentOption == options[1]
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyInputField(
                                  title: "Date",
                                  hint: DateFormat.yMd().format(_selectedDate),
                                  widget: IconButton(
                                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                                    onPressed: () {
                                      print("object");
                                      _getDateFromUser();
                                    },
                                  ),
                                ),
                                // Date selected.
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyInputField(
                                        title: "start Date",
                                        hint: _startTime,
                                        widget: IconButton(
                                          onPressed: () {
                                            _getTimeFromUser(isStartTime: true);
                                          },
                                          icon: Icon(
                                            Icons.access_time_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: MyInputField(
                                        title: "End Date",
                                        hint: _endTime,
                                        widget: IconButton(
                                          onPressed: () {
                                            _getTimeFromUser(isStartTime: false);
                                          },
                                          icon: Icon(
                                            Icons.access_time_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      currentOption == options[0]
                          ? Container()
                          : Container(
                              alignment: Alignment.centerLeft,
                              child: MyInputField(
                                title: "Ngày dự kiến",
                                hint:
                                    "khoảng thời gian nào đó trong tuần? Hoặc là trong khoảng thời gian từ ngày nào đến ngày nào? ...",
                                controller: _fullName,
                              ),
                            ),
                      SizedBox(
                        height: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            maxLines: 10, //or null
                            decoration:
                                InputDecoration.collapsed(hintText: "Tình trạng của khách hàng..."),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyButton(
                    onPressed: () {
                      _validateDate();
                    },
                    label: 'Login Now',
                    stretch: true,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  _clearSearchData() {
    print("Click to clear Data button.");
  }

  // TODO: Validate data.
  _validateDate() {
    // if (_titleController!.text.isNotEmpty && _noteController!.text.isNotEmpty) {
    //   print('Tap in here. And insert to DB');
    //   // Add to database.
    _addTaskToDB();
    // } else if (_titleController!.text.isEmpty || _noteController!.text.isEmpty) {
    //   Get.snackbar("Required", "All fields are required!!",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.white,
    //       icon: Icon(Icons.warning_amber_rounded));
    // }
  }

  // Date picker
  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
        print(_selectedDate);
      });
    } else {
      print("It's null or something wrong");
    }
  }

  // Time picker
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                  print("$index");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _addTaskToDB() async {
    // Set data to database.
    // var value = await _orderProvider.addOrder(
    //     request: TherapyOrderRequest(
    //       id: null,
    //         requester:_requester,
    //         orderDate:_or
    //         String? phoneNo;
    //     String? address;
    //     startTime:
    //         String? endTime;
    //         String? howToKnow;
    //         String? userStatus;
    //     String? serviceType;
    //
    //         note: _noteController!.text,
    //         title: _titleController!.text,
    //         date: DateFormat.yMd().format(_selectedDate),
    //         startTime: _startTime,
    //         endTime: _endTime,
    //         remind: _selectedRemind,
    //         repeat: _selectedRepeat,
    //         color: _selectedColor,
    //         isCompleted: 0));
    print("My ID");
  }
}
