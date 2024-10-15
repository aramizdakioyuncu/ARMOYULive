import 'package:armoyu_desktop/app/modules/mainpage/_main/views/homepage_view.dart';
import 'package:armoyu_desktop/app/utils/applist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedPage = 0.obs;
    final pageController = PageController(initialPage: selectedPage.value);

    return Scaffold(
      body: Row(
        children: [
          Container(
            color: const Color.fromARGB(255, 21, 21, 21),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: InkWell(
                      onTap: () {
                        pageController.jumpToPage(0);
                        selectedPage.value = 0;
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundImage: CachedNetworkImageProvider(
                          "https://aramizdakioyuncu.com/galeri/ana-yapi/armoyu64.png",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  ...List.generate(
                    AppList.groups.length,
                    (index) {
                      return Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: InkWell(
                            onTap: () {
                              pageController.jumpToPage(index + 1);
                              selectedPage.value = index + 1;
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(width: 50),
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundImage:
                                          CachedNetworkImageProvider(
                                        AppList.groups[index].logo.minUrl,
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: -3,
                                  child: Container(
                                    height: 6,
                                    width: 6,
                                    decoration: BoxDecoration(
                                      color: selectedPage.value - 1 == index
                                          ? Colors.red
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                selectedPage.value = value;
              },
              children: [
                const HomepageView(),
                ...List.generate(
                  AppList.groups.length,
                  (index) {
                    return AppList.groups[index].pageDetail(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
