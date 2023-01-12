import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jemputah_app_driver/API/FetchData.dart';
import 'package:jemputah_app_driver/API/FetchDataJemput.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/icons.dart';
import 'package:jemputah_app_driver/constants/images.dart';
import 'package:jemputah_app_driver/constants/variable.dart';
import 'package:jemputah_app_driver/extensions/time_code_converter.dart';
import 'package:jemputah_app_driver/screens/detail_penjemputan_screen.dart';
import 'package:jemputah_app_driver/screens/transaksi_screen.dart';
import 'package:jemputah_app_driver/screens/tukar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HistoryTransactionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(
        bottom: 40,
        right: 15,
      ),
      icon: Image.asset(
        iconTransaksi,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return const TransaksiScreen();
          },
        ));
      },
    );
  }
}

class _LeadAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: 350,
          height: 50,
          margin: const EdgeInsets.only(
            left: 14,
            top: 5,
          ),
          child: Image.asset(
            homeLogo,
            fit: BoxFit.contain,
            scale: 0.2,
          ),
        ),
      ],
    );
  }
}

class _JemputBox extends StatelessWidget {
  final dynamic berat;
  final dynamic jmlJemput;
  final dynamic koin;
  final String username;

  const _JemputBox(
    this.username,
    this.koin,
    this.jmlJemput,
    this.berat,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryBorder,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppColors.secondaryBorder,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 30,
            ),
            height: 35,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    username,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 21,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    koin.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ),
                const Text(
                  " Koin",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColors.black,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 180,
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          "$jmlJemput Jemput",
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Text(
                        "$berat Kg",
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(
                  right: 28,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const TukarScreen();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    minimumSize: const Size(110, 35),
                  ),
                  child: const Text("Tukar Koin"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Carousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<_Carousel> {
  CarouselController carouselButton = CarouselController();

  int currentPos = 0;
  List<String> carouselImg = [
    carousel1,
    carousel2,
    carousel3,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          height: 170,
          child: CarouselSlider.builder(
            itemCount: carouselImg.length,
            options: CarouselOptions(
              height: 154,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.6,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPos = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return CarouselView(carouselImg[index]);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselImg.map((url) {
            int index = carouselImg.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPos == index ? AppColors.black : AppColors.white,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CarouselView extends StatelessWidget {
  final String path;

  const CarouselView(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        child: Image.asset(
          path,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class _JadwalJemput extends StatelessWidget {
  final List<Map<String, dynamic>> penjemputan;
  final List usersName;

  _JadwalJemput(
    this.penjemputan,
    this.usersName,
  );

  final TimeCodeConverter timeCodeConverter = TimeCodeConverter();

  Widget listJemput(BuildContext context) {
    if (penjemputan.isEmpty || usersName.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 3.5,
        child: const Center(
          child: Text("Belum ada Penjemputan"),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 17,
        ),
        height: MediaQuery.of(context).size.height -
            75 -
            130 * (6 - penjemputan.length),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: penjemputan.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 113,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                color: AppColors.jadwalCardBackground,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                    left: 10,
                  ),
                  visualDensity: const VisualDensity(
                    horizontal: 0,
                    vertical: 4,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 5,
                    ),
                    child: Text(
                      penjemputan[index]["date"] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          usersName[index],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        penjemputan[index]["address"] as String,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  leading: SizedBox(
                    width: 85,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          iconJadwal,
                          width: 45,
                          height: 45,
                          fit: BoxFit.fill,
                        ),
                        const Spacer(),
                        Text(
                          timeCodeConverter.timeCodeConverter(
                              penjemputan[index]["time_code"]),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: const SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.navigate_next,
                      size: 60,
                    ),
                  ),
                  dense: true,
                  horizontalTitleGap: 7,
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return DetailPenjemputanScreen(
                              penjemputan[index]["id_jemput"]);
                        },
                      ),
                    ),
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 1,
            height: 10,
            color: AppColors.backgroundGreen,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(
            top: 23.4,
            bottom: 10,
            left: 22,
          ),
          child: const Text(
            "Jadwal Penjemputanmu : ",
            textAlign: TextAlign.left,
          ),
        ),
        listJemput(context),
      ],
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var driverName = "Account";
  dynamic jmlKoinDriver = 0;
  dynamic jmlJemput = 0;
  dynamic jmlBerat = 0;
  List<Map<String, dynamic>> data = [];
  List usersName = [];

  void setJemput() {
    var penjemputan = FetchDataJemput().fetchListJemputNotDone(uid);
    penjemputan.then((value) {
      setState(() {
        data = value;
        List usersID = data.map((map) => map["id_user"]).toList();
        setUser(usersID);
      });
    });
  }

  void setUser(List userID) {
    for (var element in userID) {
      var user = FetchData().fetchMapData("user", element);
      user.then((value) {
        setState(() {
          usersName.add(value["name_user"]);
        });
      });
    }
  }

  void set() {
    var driver = FetchData().fetchMapData("driver", uid);
    driver.then((value) {
      setState(() {
        driverName = value["name_driver"];
        jmlKoinDriver = value["jml_koin_driver"];
        jmlJemput = value["jml_jemput"];
        jmlBerat = value["jml_berat"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    set();
    setJemput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      appBar: AppBar(
        leadingWidth: 200,
        backgroundColor: AppColors.backgroundGreen,
        toolbarHeight: 87,
        elevation: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_LeadAppBar()],
        ),
        actions: [
          _HistoryTransactionButton(),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  _JemputBox(driverName, jmlKoinDriver, jmlJemput, jmlBerat),
                  _Carousel(),
                  _JadwalJemput(data, usersName),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
