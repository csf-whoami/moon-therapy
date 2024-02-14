import 'package:flutter/material.dart';

import '../../../../core/core.dart';

import './tabs/firstScreen.dart';
import './tabs/secondScreen.dart';

class About extends StatefulWidget {
  final String? title;
  const About({Key? key, this.title}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  late TextEditingController _name;
  late String display;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: 'Guest');
    display = 'Quản lý trị liệu';
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: actionsMenu(context),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 55,
                color: Colors.white,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding:
                      EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
                  unselectedLabelColor: Colors.pink,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pinkAccent),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Colors.pinkAccent, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Yêu cầu'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Colors.pinkAccent, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Danh sách trị liệu'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(
              children: [
                ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: 20,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () {},
                          title: Text("Yêu cầu trị liệu ${index + 1}"),
                          subtitle: Text("Tình trạng hiện tại"),
                          trailing: Icon(Icons.ice_skating));
                    }),
                ListView.separated(
                    padding: EdgeInsets.all(10),
                    itemCount: 20,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () {},
                          title: Text("Lần trị liệu ${index + 1}"),
                          subtitle: Text("Tình trạng điều trị"),
                          trailing: Icon(Icons.arrow_circle_right));
                    })
              ],
            ))
          ],
        ),

        // TODO: Old arrange.
        // width: double.infinity,
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(display),
        //     Center(
        //       child: EditableText(
        //         textAlign: TextAlign.center,
        //         controller: _name,
        //         focusNode: FocusNode(),
        //         style: TextStyle(
        //           color: theme.textTheme.bodyText1!.color,
        //           fontSize: 20,
        //         ),
        //         cursorColor: theme.textTheme.bodyText1!.color!,
        //         backgroundCursorColor: Colors.yellowAccent,
        //       ),
        //     ),
        //   ],
        // ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
