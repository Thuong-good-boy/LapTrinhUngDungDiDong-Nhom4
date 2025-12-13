import 'package:flutter/material.dart';

class BaiTap1 extends StatelessWidget {
  const BaiTap1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Khóa học của tôi")
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    final data = <Course>[
      Course(
        title: 'XML và ứng dụng - Nhóm 1',
        instructor: '2025-2026.1.TIN4583.001',
        students: '58 học viên',
        image: 'assets/images/1 (1).png',
      ),
      Course(
        title: 'Lập trình ứng dụng cho các t...',
        instructor: '2025-2026.1.TIN4403.006',
        students: '55 học viên',
        image: 'assets/images/1 (2).png',
      ),
      Course(
        title: 'Lập trình ứng dụng cho các t...',
        instructor: '2025-2026.1.TIN4403.005',
        students: '52 học viên',
        image: 'assets/images/1 (3).png',
      ),
      Course(
        title: 'Lập trình ứng dụng cho các t...',
        instructor: '2025-2026.1.TIN4403.004',
        students: '50 học viên',
        image: 'assets/images/1 (4).png',
      ),
      Course(
        title: 'Lập trình ứng dụng cho các t...',
        instructor: '2025-2026.1.TIN4403.003',
        students: '52 học viên',
        image: 'assets/images/1 (5).png',
      ),
    ];

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return item(data[index]);
      },
    );
  }

  Widget item(Course course) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(course.image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      course.instructor,
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    )
                  ],
                ),
                Text(
                  course.students,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              print("More clicked");
            },
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}

class Course {
  final String title;
  final String instructor;
  final String students;
  final String image;

  Course({
    required this.title,
    required this.instructor,
    required this.students,
    required this.image,
  });
}