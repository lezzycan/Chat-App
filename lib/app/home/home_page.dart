import 'package:flutter/material.dart';
import 'package:time_tracker/app/home/account/account_page.dart';
import 'package:time_tracker/app/home/cupertino_home_scaffold.dart';
import 'package:time_tracker/app/home/tab_item.dart';

import 'jobs/jobs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;
  void _select(TabItem tabItem) {
    if(tabItem == _currentTab){
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }else{
      setState(() => _currentTab = tabItem);
    }

  }
  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => const JobsPage(),
      TabItem.entries: (_) => Container(),
      TabItem.accounts: (_) => const AccountPage(),
    };
  }
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys ={
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.accounts: GlobalKey<NavigatorState>(),


  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
          currentTab: _currentTab,
          onSelectTab: (item) => _select(item),
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,),
    );
  }
}
