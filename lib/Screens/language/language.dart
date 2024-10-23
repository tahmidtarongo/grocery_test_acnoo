import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mobile_pos/GlobalComponents/button_global.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import '../Home/home.dart';
import 'language_provider.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key, this.alreadySelectedLanguage}) : super(key: key);

  final String? alreadySelectedLanguage;

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  List<String> languageList = [
    'English',
    'Chinese',
    'Hindi',
    'French',
    'Spanish',
    'Japanese',
    'Arabic',
    'Romanian',
    'Italian',
    'German',
    'Vietnamese',
    'Русский',
    'Indonesian',
    'Korean',
    'Serbian',
    'Polish',
    'Persian',
    'Ukrainian',
    'Bangla',
    'Malay',
    'Lao',
    'Turkish',
    'Portuguese',
    'Hungarian',
    'Hebrew',
    'Thai',
    'Dutch',
    'Finland',
    'Greek',
    'Khmer',
    'Bosnian',
    'Swahili',
    'Slovak',
    'Sinhala',
    'Urdu',
    'Kannada',
    'Marathi',
    'Tamil',
    'Afrikans',
    'Czech',
    'Swedish',
    'Albanian',
    'Danish',
    'Azerbaijani',
    'Kazakh',
    'Crotian',
    'Nepali',
    'Burmese',
    'Amharic',
    'Assamese',
    'Belarusian',
    'Catalan Valencian',
    'Welsh',
    'Estonian',
    'Basque',
    'Filipino',
    'Galician',
    'Swiss',
    'Gujarati',
    'Armenian',
    'Icelandic',
    'Georgian',
    'Kirghiz Kyrgyz',
    'Lithuanian',
    'Latvian',
    'Macedonian',
    'Malayalam',
    'Mongolian',
    'Norwegian Bokmål',
    'Norwegian',
    'Oriya',
    'Panjabi',
    'Pushto',
    'Slovenian',
    'Telugu',
    'Tagalog',
    'Uzbek',
    'Zulu'
  ];

  String selectedLanguage = 'English';

  Future<void> saveData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.alreadySelectedLanguage != null) {
      selectedLanguage = widget.alreadySelectedLanguage!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ButtonGlobalWithoutIcon(
          buttontext: lang.S.of(context).save,
          buttonDecoration: kButtonDecoration.copyWith(
            color: kMainColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          onPressed: () async {
            context.read<LanguageChangeProvider>().changeLocale(languageMap[selectedLanguage]!);
            await saveData(selectedLanguage);

            setState(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
            });
          },
          buttonTextColor: Colors.white),
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: kWhite,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            FeatherIcons.x,
            color: kTitleColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          lang.S.of(context).selectLang,
          style: const TextStyle(color: kTitleColor),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
              itemCount: languageList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return StatefulBuilder(
                  builder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            selectedLanguage = languageList[index];
                          });
                        },
                        contentPadding: const EdgeInsets.only(left: 10, right: 10.0),
                        horizontalTitleGap: 10,
                        title: Text(languageList[index]),
                        trailing: Icon(
                          selectedLanguage == languageList[index] ? Icons.radio_button_checked_outlined : Icons.circle_outlined,
                          color: selectedLanguage == languageList[index] ? kMainColor : Colors.grey,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
