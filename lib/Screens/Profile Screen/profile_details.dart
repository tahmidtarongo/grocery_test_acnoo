import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_pos/GlobalComponents/button_global.dart';
import 'package:mobile_pos/Screens/Authentication/login_form.dart';
import 'package:mobile_pos/Screens/Profile%20Screen/edit_profile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Const/api_config.dart';
import '../../Provider/profile_provider.dart';
import '../../constant.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final businessInfo = ref.watch(businessInfoProvider);

      return businessInfo.when(data: (details) {
        TextEditingController addressController = TextEditingController(text: details.address);
        TextEditingController openingBalanceController = TextEditingController(text: details.shopOpeningBalance.toString());
        TextEditingController phoneController = TextEditingController(text: details.phoneNumber);
        TextEditingController nameController = TextEditingController(text: details.companyName);
        TextEditingController categoryController = TextEditingController(text: details.category?.name);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              lang.S.of(context).profile,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(
                            profile: details,
                            ref: ref,
                          ),
                        ));
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: kMainColor,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        lang.S.of(context).edit,
                        style: GoogleFonts.poppins(
                          color: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          bottomNavigationBar: ButtonGlobal(
            iconWidget: Icons.arrow_forward,
            buttontext: lang.S.of(context).changePassword,
            iconColor: Colors.white,
            buttonDecoration: kButtonDecoration.copyWith(color: kMainColor),
            onPressed: () async {
              try {
                EasyLoading.show(status: 'Sending Email', dismissOnTap: false);
                await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: FirebaseAuth.instance.currentUser!.email.toString(),
                );
                EasyLoading.showSuccess('Email Sent! Check your Inbox');
                // ignore: use_build_context_synchronously
                const LoginForm(
                  isEmailLogin: true,
                ).launch(context);
                FirebaseAuth.instance.signOut();
              } catch (e) {
                EasyLoading.showError(e.toString());
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: details.pictureUrl == null
                          ? BoxDecoration(
                              image: const DecorationImage(image: AssetImage('images/no_shop_image.png'), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(50),
                            )
                          : BoxDecoration(
                              image: DecorationImage(image: NetworkImage(APIConfig.domain + details.pictureUrl), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(50),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  ///________Name___________________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppTextField(
                      readOnly: true,
                      cursorColor: kGreyTextColor,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: lang.S.of(context).name,
                        border: const OutlineInputBorder().copyWith(borderSide: const BorderSide(color: kGreyTextColor)),
                        hoverColor: kGreyTextColor,
                        fillColor: kGreyTextColor,
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                  ),

                  ///_____________Category__________________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppTextField(
                      readOnly: true,
                      cursorColor: kGreyTextColor,
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: lang.S.of(context).businessCat,
                        border: const OutlineInputBorder().copyWith(borderSide: const BorderSide(color: kGreyTextColor)),
                        hoverColor: kGreyTextColor,
                        fillColor: kGreyTextColor,
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                  ),

                  ///_____________Phone_________________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppTextField(
                      readOnly: true,
                      cursorColor: kGreyTextColor,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: lang.S.of(context).phone,
                        border: const OutlineInputBorder().copyWith(borderSide: const BorderSide(color: kGreyTextColor)),
                        hoverColor: kGreyTextColor,
                        fillColor: kGreyTextColor,
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                  ),

                  ///__________Address_________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppTextField(
                      readOnly: true,
                      cursorColor: kGreyTextColor,
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: lang.S.of(context).address,
                        border: const OutlineInputBorder().copyWith(borderSide: const BorderSide(color: kGreyTextColor)),
                        hoverColor: kGreyTextColor,
                        fillColor: kGreyTextColor,
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                  ),

                  ///__________Opening_Balance________________________
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppTextField(
                      readOnly: true,
                      cursorColor: kGreyTextColor,
                      controller: openingBalanceController,
                      decoration: InputDecoration(
                        labelText: 'Shop Opening Balance',
                        border: const OutlineInputBorder().copyWith(borderSide: const BorderSide(color: kGreyTextColor)),
                        hoverColor: kGreyTextColor,
                        fillColor: kGreyTextColor,
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, error: (e, stack) {
        return Text(e.toString());
      }, loading: () {
        return const CircularProgressIndicator();
      });
    });
  }
}
