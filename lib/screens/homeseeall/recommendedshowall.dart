import 'package:flutter/material.dart';
import 'package:gofoods/custtomscreens/custtomrecommended.dart';
import 'package:gofoods/services/category_products_services.dart';
import 'package:gofoods/utils/mediaqury.dart';
import 'package:gofoods/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedSeeall extends StatefulWidget {
  static const routeName = '/category-wise-product';
  const RecommendedSeeall({Key? key}) : super(key: key);

  @override
  State<RecommendedSeeall> createState() => _RecommendedSeeallState();
}

class _RecommendedSeeallState extends State<RecommendedSeeall> {
  late ColorNotifier notifier;
  bool isLoading = false;
  String category = '';
  List<dynamic> categoryData = [];

  final CategoryProductServices categoryProductServices =
      CategoryProductServices();

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    getCategorydata();
  }

  getCategorydata() async {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      category = ModalRoute.of(context)!.settings.arguments as String;
      categoryData =
          await categoryProductServices.getCategoryProducts(context, category);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
        backgroundColor: notifier.getwhite,
        appBar: AppBar(
          backgroundColor: notifier.getwhite,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: notifier.getblackcolor,
              size: height / 30,
            ),
          ),
          title: Text(
            category,
            style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 45,
                fontFamily: 'GilroyBold'),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemCount: categoryData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: height / 2.7,
                      crossAxisSpacing: width / 50,
                      mainAxisSpacing: height / 80,
                    ),
                    itemBuilder: (context, index) {
                      final name = categoryData[index]['businessName'];
                      final address = categoryData[index]['address']
                              ['locality'] +
                          "," +
                          categoryData[index]['address']['city'];
                      final id = categoryData[index]['_id'];
                      final category = categoryData[index]['businessType'];
                      return CusttomRecommended(
                        bgimage: "assets/bfood.jpg",
                        adressredto: address,
                        category: category,
                        id: id,
                        name: name,
                      );
                    },
                  ),
                ],
              ));
  }
}


// SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CusttomRecommended("assets/bfood.jpg", LanguageEn.donzs,
//                           LanguageEn.westernburgerfast),
//                       SizedBox(width: width / 40),
//                       CusttomRecommended("assets/cake.jpg",
//                           LanguageEn.burgerkings, LanguageEn.westernburgerfast),
//                     ],
//                   ),
//                   SizedBox(height: height / 60),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CusttomRecommended("assets/cake.jpg", LanguageEn.atul,
//                           LanguageEn.westernburgerfast),
//                       SizedBox(width: width / 40),
//                       CusttomRecommended("assets/bfood.jpg", LanguageEn.mayo,
//                           LanguageEn.westernburgerfast),
//                     ],
//                   ),
//                   SizedBox(height: height / 60),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CusttomRecommended("assets/bfood.jpg", LanguageEn.donzs,
//                           LanguageEn.westernburgerfast),
//                       SizedBox(width: width / 40),
//                       CusttomRecommended("assets/cake.jpg",
//                           LanguageEn.derryfresh, LanguageEn.westernburgerfast),
//                     ],
//                   ),
//                   SizedBox(height: height / 40),
//                 ],
//               ),
//             ),