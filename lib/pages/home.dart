import "package:fitness/models/diet_model.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../models/category_model.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
  }

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 16),
          _categoriesSection(),
          const SizedBox(
            height: 16,
          ),
          _dietSection(),
          const SizedBox(
            height: 16,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Popular",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("Recommendation \nfor Diet",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 190,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 210,
                  decoration: BoxDecoration(
                      color: diets[index].boxColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 90,
                          width: 90,
                          child: SvgPicture.asset(diets[index].iconPath)),
                      Column(
                        children: [
                          Text(
                            diets[index].name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${diets[index].level} | ${diets[index].calorie} | ${diets[index].duration}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 90,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              diets[index].viewIsSelected
                                  ? const Color.fromARGB(255, 142, 183, 255)
                                  : Colors.transparent,
                              diets[index].viewIsSelected
                                  ? Colors.blue
                                  : Colors.transparent,
                            ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "View",
                          style: TextStyle(
                              color: diets[index].viewIsSelected
                                  ? Colors.white
                                  : Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 25,
                );
              },
              itemCount: diets.length),
        )
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Category",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 120,
          padding: const EdgeInsets.only(left: 12),
          child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: ((context, index) {
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                      Text(
                        categories[index].name,
                      )
                    ],
                  ),
                );
              })),
        )
      ],
    );
  }

  Container _searchField() {
    return Container(
        margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 40,
              spreadRadius: 0.0)
        ]),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(10),
            hintText: "Search Pancake",
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            prefixIcon: Padding(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset("assets/icons/Search.svg")),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.4,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(17),
                        child: SvgPicture.asset("assets/icons/Filter.svg")),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Breakfast"),
      titleTextStyle: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              "./assets/icons/left-arrow-svgrepo-com.svg",
              width: 10,
              height: 10,
            ),
          )),
      actions: [
        GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                "./assets/icons/two-dots-svgrepo-com.svg",
                width: 10,
                height: 10,
              ),
            ))
      ],
    );
  }
}
