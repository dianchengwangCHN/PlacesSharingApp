import 'package:flutter/material.dart';
import '../find_place/find_place_page.dart';
import '../share_place/share_place_page.dart';

class MainTabsPage extends StatefulWidget {
  @override
  _MainTabsPageState createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FindPlacePage(),
          SharePlacePage(),
        ],
      ),
      bottomNavigationBar: Material(
        child: TabBar(
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: <Tab>[
            Tab(text: "Find Place", icon: Icon(Icons.map)),
            Tab(text: "Share Place", icon: Icon(Icons.share)),
          ],
          indicatorColor: Colors.orange,
        ),
      ),
    );
  }
}
