import 'package:flutter/material.dart';

import '../profile/views/size_config.dart';
import '../profile/views/styles.dart';
import 'gamers_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  create a Firestore instance which you can use to read and write data to and from the database.
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class GamerProfile extends StatefulWidget {
  GamerProfile({super.key, required this.id});

  final String id;

  @override
  State<GamerProfile> createState() => _GamerProfileState();
}

class _GamerProfileState extends State<GamerProfile> {
  GamersModel? gamersData;
  bool isLoading = true;

  late SharedPreferences _prefs;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    readData();
    initPrefs();
  }

  Future<void> readData() async {
    await Firebase.initializeApp().then((value) async {
      print("Initialize Success");
      var x = await FirebaseFirestore.instance
          .collection('proplayers')
          .doc(widget.id)
          .get();

      x.data();
      GamersModel model = GamersModel.fromMap(x.data()!, x.id);
      gamersData = model;

      await Future.delayed(Duration(seconds: 2));
      setState(() {
        isLoading = false;
      }); //rebuild line 42 after readData();
    });
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String userId = getCurrentUserId();
    String proPlayerId = widget.id;
    isFollowing = _prefs.getBool('$userId-$proPlayerId') ?? false;
    setState(() {});
  }

// Get the current user ID
  String getCurrentUserId() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.uid;
  }

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });

    // get the current user ID and pro player ID
    final String userId = getCurrentUserId();
    final String proPlayerId = widget.id;

    // update the pro players table
    DocumentReference proPlayerRef =
        _firestore.collection('proplayers').doc(proPlayerId);
    proPlayerRef.update({
      'followers':
          isFollowing ? FieldValue.increment(1) : FieldValue.increment(-1),
    });

    // update the users table
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    userRef.update({
      'following': isFollowing
          ? FieldValue.arrayUnion([proPlayerId])
          : FieldValue.arrayRemove([proPlayerId]),
    });

    // store the follow status in local storage
    _prefs.setBool('$userId-$proPlayerId', isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: kLighterWhite,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              kBorderRadius,
                            ),
                            child: Image.network(
                              gamersData?.image_url ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 2,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gamersData!.name,
                                    style: kPoppinsBold.copyWith(
                                        color: kDarkBlue,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                4),
                                  ),
                                  Text(
                                    widget.id,
                                    style: kPoppinsRegular.copyWith(
                                        color: kDarkBlue,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                3),
                                  )
                                ],
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 42,
                                  maxWidth:
                                      SizeConfig.blockSizeHorizontal! * 60,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    kBorderRadius,
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: ElevatedButton(
                                  onPressed: _toggleFollow,
                                  child:
                                      Text(isFollowing ? 'Unfollow' : 'Follow'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2.5,
                    ),
                    Text(
                      gamersData!.experience,
                      style: kPoppinsMedium.copyWith(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal! * 4),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2.5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 3,
                        vertical: SizeConfig.blockSizeVertical! * 3.5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        color: kDarkBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  gamersData!.followers.toString(),
                                  style: kPoppinsBold.copyWith(
                                      color: kWhite,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 4),
                                ),
                                Text(
                                  'followers',
                                  style: kPoppinsMedium.copyWith(
                                      color: kWhite,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 3),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: SizeConfig.blockSizeVertical! * 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: kLightBlue,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  gamersData!.posts,
                                  style: kPoppinsBold.copyWith(
                                      color: kWhite,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 4),
                                ),
                                Text(
                                  'Posts',
                                  style: kPoppinsMedium.copyWith(
                                      color: kWhite,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 3),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: SizeConfig.blockSizeVertical! * 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: kLightBlue,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  gamersData!.following.toString(),
                                  style: kPoppinsBold.copyWith(
                                      color: kWhite,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 4),
                                ),
                                Text(
                                  'following',
                                  style: kPoppinsMedium.copyWith(
                                      color: kWhite,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 3),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // ElevatedButton(
                    //   onPressed: _toggleFollow,
                    //   child: Text(isFollowing ? 'Unfollow' : 'Follow'),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            "https://www.buymeacoffee.com/explore/gaming/");
                        await launchUrl(url);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.coffee,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Buy Me A Coffee',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Games',
                          style: kPoppinsBold.copyWith(
                              color: kDarkBlue,
                              fontSize: SizeConfig.blockSizeHorizontal! * 3.8),
                        ),
                        Text(
                          'View All',
                          style: kPoppinsBold.copyWith(
                              color: kDarkBlue,
                              fontSize: SizeConfig.blockSizeHorizontal! * 3),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String gameName, gameImage;
                          if (index == 0) {
                            gameName = gamersData!.game;
                            gameImage = gamersData!.game_image;
                          } else {
                            gameName = gamersData!.game2;
                            gameImage = gamersData!.game2_image;
                          }
                          return Container(
                            height: 100,
                            margin: EdgeInsets.only(
                              bottom: SizeConfig.blockSizeVertical! * 2.5,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 3),
                                          color: kDarkBlue.withOpacity(0.051),
                                        )
                                      ]),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius),
                                    child: Image.network(
                                      gameImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical! * 2.5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Interests',
                                        style: kPoppinsRegular.copyWith(
                                            color: kDarkBlue,
                                            fontSize: SizeConfig
                                                    .blockSizeHorizontal! *
                                                2.5),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical! * 1,
                                      ),
                                      Text(
                                        gameName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: kPoppinsSemibold.copyWith(
                                            color: kDarkBlue,
                                            fontSize: SizeConfig
                                                    .blockSizeHorizontal! *
                                                3),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical! * 1,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // followingButton() {
  //   currentUserId = FirebaseAuth auth = FirebaseAuth.instance;
  //   if (auth.currentUser != null) {
  //     print(auth.currentUser.uid);
  //   }

  //   bool isProfileOwner = currentUserId == widget.id ;
  //   if (isFollowing) {
  //     return Text('Unfollow', function: handleUnfollowUser);
  //   }
  // } else if (!isFollowing) {
  //   return Text('Follow')
  // }

  // Container buildButton({String text, Function function}) {
  //   return Container(
  //     padding: EdgeInsets.only(top: 2.0),
  //     child: ElevatedButton(
  //       onPressed: function,
  //     child: Container(
  //       width: 250.0,
  //       height: 27.0,
  //       child: Text(text, style: TextStyle(
  //         color: isFollowing ? Colors.black : Colors.white,
  //         fontWeight: FontWeight.bold,
  //       ),),
  //     )),
  //   );
  // }
}
