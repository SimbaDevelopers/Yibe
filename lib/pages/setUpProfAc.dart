import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yibe_final_ui/model/prof_user_model.dart';
import 'package:yibe_final_ui/pages/PageHandler.dart';
import 'package:yibe_final_ui/pages/Profile.dart';
import 'package:yibe_final_ui/services/database.dart';
import 'package:yibe_final_ui/services/media_service.dart';
import 'package:yibe_final_ui/services/messaging_service.dart';
import 'package:yibe_final_ui/services/navigation_service.dart';
import 'package:yibe_final_ui/services/storage_service.dart';
import 'package:yibe_final_ui/utils/constants.dart';
import 'package:yibe_final_ui/utils/helper_functions.dart';


class SetUpProfessionalAccount extends StatefulWidget {

  @override
  _SetUpProfessionalAccountState createState() => _SetUpProfessionalAccountState();
}

class _SetUpProfessionalAccountState extends State<SetUpProfessionalAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'prof-account-setup-page');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _profAccountNameController = TextEditingController();
  final TextEditingController _profAccountUserNameController = TextEditingController();
  final TextEditingController _profAccountBioController = TextEditingController();
  static ProfUserModel prfUserMap = ProfUserModel();
  var uuid = Uuid();
  String profUid;
  File _profImage;
  String _profProfileUrl;

  @override
  void initState(){
    super.initState();
    setState(() {
      profUid = uuid.v4();
    });
  }

  @override
  void dispose() {
    _profAccountNameController.dispose();
    _profAccountBioController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: FutureBuilder(
            future: DatabaseService.instance.getProfAcStatus(),
            // ignore: missing_return
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container();
                  break;
                case ConnectionState.done:
                  if (snapshot.data !=true) {
                    return setUpProfAcForm();
                  }
                  else {
                    return PageHandler();
                  }
                  break;
                default:
                  if (snapshot.hasError) {
                    setUpProfAcForm();
                  }
              }},
          ),
        ),
      ),
    );
  }

  Widget setUpProfAcForm(){

    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Tap the image to change profile pic',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700], fontSize: 15.0)),

                SizedBox(height: 20.0),

                InkWell(
                    onTap: () => _bottomSheet(context), //open camera or gallery
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _profImage != null ? FileImage(_profImage) : UniversalVariables.defaultImage,
                    )),
                TextFormField(
                  controller: _profAccountNameController,
                  decoration: const InputDecoration(labelText: 'Business Name'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'business name cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _profAccountUserNameController,
                  decoration: const InputDecoration(labelText: 'User Name'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'user name cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _profAccountBioController,
                  maxLength: 100,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'add what your business do';
                    }
                    return null;
                  },
                ),
                Spacer(),
                FlatButton(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    color: primaryColor,
                    child: Text('Proceed'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        HelperFunction.saveUserProfUidAsSharedPreference(profUid);
                        await StorageService.instance.uploadProfProfilePic(_profImage, profUid).then((val) => setState(() {
                          _profProfileUrl = val;
                        }));
                        prfUserMap = ProfUserModel(
                          profId: profUid,
                          pvtId: UniversalVariables.myPvtUid,
                          accountType: 'Professional',
                          businessName: _profAccountNameController.text,
                          businessBio: _profAccountBioController.text,
                          profUserName: _profAccountUserNameController.text,
                          fcmToken: await MessagingService.instance.getToken(),
                          profUrl: _profProfileUrl,
                        );
                        passProfUserInfoToDB(profUid);
                        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PageHandler()));
                      }
                    }
                ),
              ],
            ),
          ),
        ));
  }

  void passProfUserInfoToDB(String profUid) async {
    await DatabaseService.instance.updateHaveAProfAc(profUid);
    await DatabaseService.instance.createProfUserInDB(prfUserMap.toMap(prfUserMap));
    await DatabaseService.instance.createProfUserInAllUserCollection(prfUserMap.toMap(prfUserMap));
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.add_a_photo, color: primaryColor),
                    hoverColor: primaryColor,
                    title: Text('Camera'),
                    onTap:  () async {
                      File _image = await MediaService.instance.getCamImage();
                      setState(() {
                        _profImage = _image;
                      });
                      NavigationService.instance.goBack();
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.add_photo_alternate, color: primaryColor,),
                    hoverColor: primaryColor,
                    title: Text('Gallery'),
                    onTap:  () async {
                      File _image = await MediaService.instance.getGalleryImage();
                      setState(() {
                        _profImage = _image;
                      });
                      NavigationService.instance.goBack();
                    }
                ),
              ],
            ),
          );
        }
    );
  }

}