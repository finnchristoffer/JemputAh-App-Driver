import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jemputah_app_driver/constants/color.dart';
import 'package:jemputah_app_driver/constants/icons.dart';
import 'package:jemputah_app_driver/constants/image.dart';
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
            return TransaksiScreen();
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
  final int berat = 10;
  final int jmlJemput = 5;
  final int koin = 1500;
  final String username = "Adit Dudung";

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
          color: const Color.fromRGBO(178, 186, 159, 1),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: const Color.fromRGBO(178, 186, 159, 1),
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
                  width: 150,
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
                        return TukarScreen();
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
  final penjemputan = [
    {
      "tgl": "Jumat, 23 September 2022",
      "jam": "08:00 - 10:00",
      "nama": "Bambang Triadi",
      "alamat": "Jalan Lengkong Besar No. 47",
    },
    {
      "tgl": "Sabtu, 24 September 2022",
      "jam": "08:00-10:00",
      "nama": "Briana Tamon",
      "alamat": "Jalan Lengkong Kecil No. 47",
    }
  ];

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
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 17,
          ),
          height: 250,
          child: ListView.separated(
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
                        penjemputan[index]["tgl"] as String,
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
                            penjemputan[index]["nama"] as String,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          penjemputan[index]["alamat"] as String,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    leading: SizedBox(
                      width: 71,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            iconJadwal,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                          const Spacer(),
                          Text(
                            penjemputan[index]["jam"] as String,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const SizedBox(
                      width: 55,
                      child: Icon(
                        Icons.navigate_next,
                        size: 60,
                      ),
                    ),
                    dense: true,
                    horizontalTitleGap: 13,
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const DetailPenjemputanScreen();
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
        ),
      ],
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
                  _JemputBox(),
                  _Carousel(),
                  _JadwalJemput(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
