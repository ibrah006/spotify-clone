import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/home/components/bottom_navbar.dart';
import 'package:spotify/home/home_page.dart';
import 'package:spotify/library/library_page.dart';
import 'package:spotify/main.dart';
import 'package:spotify/search/providers/search_provider.dart';
import 'package:spotify/search/search_page.dart';
import 'package:spotify/tab_manager/helpers/tab_info.dart';

class TabManager extends StatefulWidget {
  const TabManager({super.key});

  @override
  State<TabManager> createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  int _selectedTab = 0;

  List<TabInfo> get tabs => [
        TabInfo(
          navTitle: "Good evening",
          actions: [
            InkWell(
              child: IconButton(
                icon: Icon(CupertinoIcons.bell),
                onPressed: () {},
              ),
            ),
            InkWell(
              child: IconButton(
                icon: Icon(CupertinoIcons.time),
                onPressed: () {},
              ),
            ),
            InkWell(
              child: IconButton(
                icon: Icon(CupertinoIcons.gear),
                onPressed: () {},
              ),
            ),
          ],
        ),
        TabInfo(navTitle: "Search", searchBar: true),
        TabInfo(
            navTitle: "Your Library",
            leading: CircleAvatar(
              child: Text("I",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            actions: [
              InkWell(
                child: IconButton(
                  icon: Icon(CupertinoIcons.search),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
              InkWell(
                child: IconButton(
                  icon: Icon(CupertinoIcons.add),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
            ]),
      ];

  @override
  Widget build(BuildContext context) {
    final selectedTabInfo = tabs[_selectedTab];

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SearchProvider())],
      builder: (context, child) {
        final searchProvider = context.read<SearchProvider>();

        searchQuery(String value) {
          Provider.of<SearchProvider>(context, listen: false).search(context);
        }

        return Scaffold(
            appBar: selectedTabInfo.searchBar
                ? PreferredSize(
                    preferredSize:
                        Size.fromHeight(145), // Adjust the height as needed
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20)
                          .copyWith(top: 58),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selectedTabInfo.navTitle,
                              style: MyApp.navTitleStyle),
                          SizedBox(
                              height: 15), // Space between title and search bar
                          TextField(
                            controller: searchProvider.controller,
                            onSubmitted: searchQuery,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 18)
                                  .copyWith(left: 50),
                              hintText: 'Artists, songs, or podcasts',
                              hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 5),
                                child: Icon(CupertinoIcons.search, size: 30),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(CupertinoIcons.mic, size: 30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : AppBar(
                    leadingWidth: 60,
                    centerTitle: false,
                    leading: selectedTabInfo.leading == null
                        ? null
                        : Padding(
                            padding: EdgeInsets.only(left: 19, right: 2),
                            child: selectedTabInfo.leading),
                    title: Text(selectedTabInfo.navTitle),
                    actions: selectedTabInfo.actions),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Main selected tab content/body
                [HomePage(), SearchPage(), LibraryPage()][_selectedTab],
                // Custom Bottom Navigation Bar
                BottomNavbar(
                  onChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                )
              ],
            ));
      },
    );
  }
}
