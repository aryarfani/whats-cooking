import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:whats_cooking/core/provider/user_provider.dart';
import 'package:whats_cooking/core/utils/router.dart';
import 'package:whats_cooking/ui/screens/recipe_list_widget.dart';
import 'package:whats_cooking/ui/widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabChildrenList.length, vsync: this);
  }

  final _tabChildrenList = [
    Tab(child: Text('All Recipe', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Vegetarian', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Dessert', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Bread', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Meat', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
  ];
  final _tabViewList = [
    Tab(child: RecipeListScreen()),
    Tab(child: Text('Vegetarian', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Dessert', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Bread', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
    Tab(child: Text('Meat', style: TextStyle(color: Colors.black87.withOpacity(0.8)))),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, authProv, child) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: HomeDrawer(),
            body: NestedScrollView(
              headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      title: Text(
                        'What\'s Cooking',
                        style: GoogleFonts.montserrat(color: Colors.black87),
                      ),
                      actions: [
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(RouteName.searchRecipe);
                              },
                              child: Container(
                                padding: EdgeInsets.all(14),
                                child: Icon(Icons.search, color: Colors.black87),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _scaffoldKey.currentState.openEndDrawer();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 14),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  image: authProv.currentUser != null
                                      ? DecorationImage(
                                          image: NetworkImage(authProv.currentUser.photoUrl),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      snap: true,
                      floating: true,
                      backgroundColor: Colors.white,
                      bottom: TabBar(
                        labelColor: Colors.black87,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.black45,
                        controller: tabController,
                        isScrollable: true,
                        tabs: _tabChildrenList,
                      ),
                    ),
                  )
                ];
              },
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: _tabViewList,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
