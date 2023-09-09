import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/GlobalComponents/Model/category_model.dart';
import 'package:mobile_pos/GlobalComponents/add_category.dart';
import 'package:mobile_pos/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Provider/category,brans,units_provide.dart';
import 'button_global.dart';

// ignore: must_be_immutable
class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer(builder: (context, ref, __) {
          final categoryData = ref.watch(categoryProvider);
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: AppTextField(
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: kGreyTextColor.withOpacity(0.5),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        const AddCategory().launch(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: kGreyTextColor),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: kGreyTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
              Expanded(
                child: categoryData.when(data: (data) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          final List<String> variations = [];
                          data[i].size ? variations.add('Size') : null;
                          data[i].color ? variations.add('Color') : null;
                          data[i].capacity ? variations.add('Capacity') : null;
                          data[i].type ? variations.add('Type') : null;
                          data[i].weight ? variations.add('Weight') : null;

                          GetCategoryAndVariationModel get = GetCategoryAndVariationModel(categoryName: data[i].categoryName, variations: variations);
                          return data[i].categoryName.contains(search)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[i].categoryName,
                                              style: GoogleFonts.poppins(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 20,
                                            //   width: context.width(),
                                            //   child: ListView.builder(
                                            //       shrinkWrap: true,
                                            //       physics: const NeverScrollableScrollPhysics(),
                                            //       scrollDirection: Axis.horizontal,
                                            //       itemCount: data[i]..length,
                                            //       itemBuilder: (context, index) {
                                            //         return Text(
                                            //           '${variations[index]}, ',
                                            //           style: GoogleFonts.poppins(
                                            //             fontSize: 14.0,
                                            //             color: Colors.grey,
                                            //           ),
                                            //         );
                                            //       }),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ButtonGlobalWithoutIcon(
                                          buttontext: 'Select',
                                          buttonDecoration: kButtonDecoration.copyWith(color: kDarkWhite),
                                          onPressed: () {
                                            Navigator.pop(context, get);
                                          },
                                          buttonTextColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                  );
                }, error: (_, __) {
                  return Container();
                }, loading: () {
                  return const CircularProgressIndicator();
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
