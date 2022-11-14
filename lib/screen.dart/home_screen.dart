import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shopping_ap/controllers.dart/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode = FocusNode();

  String dropdownvalue = 'smartphones';

  @override
  void initState() {
    focusNode.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return GetBuilder<ProductController>(
        builder: (ProductController controller) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: RichText(
                  text: const TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'M',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: 'oBoo',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextSpan(
                  text: 'M',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ])),
            ),
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                      autofocus: false,
                      onSubmitted: (value) {
                        controller.getSearch(value);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onChanged: (val) {
                        controller.searchVal.value = val;
                      },
                      controller: controller.searchTextEditController,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        hintText: 'What do you want to buy today?',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            controller.searchTextEditController.clear();
                            controller.searchVal.value = '';
                            controller.getApi();
                          },
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 28,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: [
                        const Text(
                          'Select Category',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black26),
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.black,
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          items: controller.dropdownitems.map((String items) {
                            return DropdownMenuItem(
                              // value: items,
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              controller.getCategory(newValue);
                            });
                          },
                          value: dropdownvalue,
                        ))
                      ],
                    ),
                  ),
                  highlightContainer(),
                  const SizedBox(height: 20),
                  Obx(() {
                    if (controller.isDataLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return controller.product.products != null &&
                              controller.product.products!.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  controller.product.products?.length ?? 0,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisExtent: 400,
                                      mainAxisSpacing: 20.0),
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 180.0,
                                              width: double.infinity,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Image.network(
                                                controller
                                                    .product
                                                    .products![index]
                                                    .images!
                                                    .first
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                color: Colors.grey[600],
                                                margin:
                                                    const EdgeInsets.all(12.0),
                                                child: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          controller
                                              .product.products![index].title!,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontFamily: 'avenir',
                                              fontWeight: FontWeight.w800),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          controller.product.products![index]
                                              .description!,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontFamily: 'avenir',
                                              fontWeight: FontWeight.w800),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                            '\$${controller.product.products![index].price!.toDouble()}',
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'avenir')),
                                        const SizedBox(height: 15),
                                        if (controller.product.products?[index]
                                                .rating !=
                                            null)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.yellow[900],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  controller.product
                                                      .products![index].rating!
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text('Not Found'));
                    }
                  }),
                  Container(
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, bottom: 25, top: 15),
                      child: bottomDetails(),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }

  Widget bottomDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SOCIALS',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      socialIcon(
                          icon: FontAwesomeIcons.facebook, onTap: (() {})),
                      socialIcon(
                          icon: FontAwesomeIcons.twitter, onTap: (() {})),
                      socialIcon(
                          icon: FontAwesomeIcons.instagram, onTap: (() {})),
                      socialIcon(icon: FontAwesomeIcons.tiktok, onTap: (() {})),
                      socialIcon(
                          icon: FontAwesomeIcons.snapchat, onTap: (() {})),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PLATFORMS',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      socialIcon(
                          icon: FontAwesomeIcons.android, onTap: (() {})),
                      socialIcon(icon: FontAwesomeIcons.apple, onTap: (() {})),
                    ],
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('SIGN UP  ',
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              elevation: 5,
              child: TextFormField(
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
                decoration: const InputDecoration(
                  labelText: 'Your email',
                  fillColor: Colors.white,
                  filled: true,
                  hoverColor: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              width: double.infinity,
              height: 50,
              color: const Color.fromARGB(255, 2, 57, 101),
              child: const Center(
                  child: Text('SUBSCRIBE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RichText(
                text: const TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'By clicking the ',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              TextSpan(
                text: 'SUBSCRIBE ',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              TextSpan(
                text: 'button, you are agreeing to our',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 25),
            child: GestureDetector(
              onTap: () {},
              child: Text('Privacy & Cookie Policy ',
                  style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 35),
            child: Text('@2010 - 2022 All Rights Reserved',
                style: TextStyle(color: Colors.black)),
          ),
          Wrap(
            children: [
              moreDetails(text: 'Privacy Center', onTap: () {}),
              moreDetails(text: 'Privacy Center', onTap: () {}),
              moreDetails(text: 'Privacy Center', onTap: () {}),
              moreDetails(text: 'Privacy Center', onTap: () {}),
              moreDetails(text: 'Privacy Center', onTap: () {}),
              moreDetails(text: 'Privacy Center', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  IconButton socialIcon({IconData? icon, GestureTapCallback? onTap}) {
    return IconButton(
      onPressed: () {},
      padding: const EdgeInsets.only(right: 8.0, top: 10, bottom: 20),
      constraints: const BoxConstraints(),
      icon: Icon(icon),
    );
  }

  Widget highlightContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.brown,
                Colors.black87,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text(
                  'Text Title',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Slash Sales egins in April. Get up to 80%',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Discount at all products',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Read More',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget moreDetails({String? text, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Text(
            text!,
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
