import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/components.dart';
import 'commons/commons.dart';
import 'login/login.dart';

class IndexPage extends StatefulWidget {

  final int initialIndex;

  const IndexPage({
    this.initialIndex = 1,
  });

  @override
  State<IndexPage> createState() => new _IndexPageState();

}

class _IndexPageState extends State<IndexPage> {

  late int _selectedIndex;

  @override
  void initState() {
    this._selectedIndex = widget.initialIndex;
    super.initState();
  }

  Widget buildBottomItem(int index, IconData iconData, String label) {
    final theme = Theme.of(context);
    Color color = _selectedIndex == index ? theme.primaryColor : theme.unselectedWidgetColor;
    return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          width: 66,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: color),
              Text(label, style: TextStyle(color: color))
            ],
          ),
        )
    );
  }

  static final List<Widget> _pages = <Widget>[
    Center(child: Text('账户', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25))),
    Center(child: Text('流水', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25))),
    Center(child: Text('图表', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25))),
    Builder(builder: (BuildContext context) {
      final state = context.watch<AuthBloc>().state;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(state.user?.userName ?? '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
            ElevatedButton(
              child: const Text('退出登录'),
              onPressed: () async {
                if (await confirm(
                  context,
                  content: Text('确定退出吗？'),
                  textOK: Text('确定'),
                  textCancel: Text('取消'),
                )) {
                  BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                }
              }
            )
          ],
        )
      );
    })
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: LazyIndexedStack(
          reuse: false,
          index: _selectedIndex,
          itemBuilder: (c, i) {
            return _pages[i];
          },
          itemCount: 4,
        ),
        bottomNavigationBar: Container(
            height: 56,
            margin: EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: theme.unselectedWidgetColor),
              ),
            ),
            child: Row(children: [
              buildBottomItem(0, Icons.account_balance_outlined, '账户'),
              buildBottomItem(1, Icons.table_rows_outlined, '流水'),
              Expanded(
                child: GestureDetector(
                  onTap: () { },
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text('记账', style: theme.textTheme.headline6!.copyWith(color: theme.colorScheme.onPrimary)),
                  ),
                ),
              ),
              buildBottomItem(2, Icons.pie_chart_outline, '图表'),
              buildBottomItem(3, Icons.person_outline_outlined, '我的'),
            ]))
    );
  }
}
