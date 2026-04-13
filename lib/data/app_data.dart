// ══════════════════════════════════════════════════════════
// LEARNLY — Data Models & Seed Data
// Real courses, instructors, and user data
// ══════════════════════════════════════════════════════════

import '../main.dart';
import 'package:flutter/material.dart';

// ── USER MODEL ───────────────────────────────────────────
// Ch05 — Domain of Protection: each user has a role/domain
class AppUser {
  final String name, email, role, avatarInitials, clearanceLevel;
  const AppUser({
    required this.name, required this.email,
    required this.role, required this.avatarInitials,
    required this.clearanceLevel,
  });
}

// Ch06 — Current logged-in user (Mirna Mohamed)
const kCurrentUser = AppUser(
  name: 'Mirna Mohamed',
  email: 'mirna.mohamed@student.mans.eg',
  role: 'Student',                // RBAC role (Ch05)
  avatarInitials: 'MM',
  clearanceLevel: 'Unclassified', // Bell-LaPadula (Ch06)
);

// ── COURSE MODEL ─────────────────────────────────────────
class Course {
  final String id, title, instructor, instructorAvatar, category,
               description, thumbnail, price, rating, students,
               duration, level;
  final List<String> whatYouLearn;
  final int lectures;
  final bool isBestseller;

  const Course({
    required this.id, required this.title, required this.instructor,
    required this.instructorAvatar, required this.category,
    required this.description, required this.thumbnail,
    required this.price, required this.rating, required this.students,
    required this.duration, required this.level,
    required this.whatYouLearn, required this.lectures,
    this.isBestseller = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id, 'title': title, 'instructor': instructor,
    'category': category, 'price': price, 'rating': rating,
    'students': students, 'thumbnail': thumbnail,
    'duration': duration, 'level': level, 'lectures': lectures,
    'isBestseller': isBestseller,
  };
}

// ── SEED DATA — Real courses ──────────────────────────────
const List<Course> kCourses = [
  Course(
    id: 'c001',
    title: 'Flutter & Dart — The Complete Guide 2025',
    instructor: 'Angela Yu',
    instructorAvatar: 'AY',
    category: 'Development',
    description: 'Become a fully-fledged Flutter developer with just one course. '
        'Includes Dart, Flutter widgets, Firebase, REST APIs and 20+ real apps.',
    thumbnail: 'https://images.pexels.com/photos/34803985/pexels-photo-34803985.jpeg?cs=srgb&dl=pexels-dkomov-34803985.jpg&fm=jpg',
    price: '549 EGP',
    rating: '4.8',
    students: '128,450',
    duration: '32 hours',
    level: 'Beginner to Advanced',
    lectures: 374,
    isBestseller: true,
    whatYouLearn: [
      'Build beautiful iOS & Android apps from scratch',
      'Master Flutter widgets and layouts',
      'Integrate Firebase (Auth, Firestore, Storage)',
      'State management with Provider & Riverpod',
      'Deploy apps to App Store and Google Play',
    ],
  ),
  Course(
    id: 'c002',
    title: 'Python Bootcamp — Zero to Hero in Python',
    instructor: 'Jose Portilla',
    instructorAvatar: 'JP',
    category: 'Development',
    description: 'Learn Python like a professional. Start from basics and go all '
        'the way to creating your own applications and games.',
    thumbnail: 'https://images.pexels.com/photos/330771/pexels-photo-330771.jpeg?cs=srgb&dl=pexels-markusspiske-330771.jpg&fm=jpg',
    price: '449 EGP',
    rating: '4.7',
    students: '96,200',
    duration: '22 hours',
    level: 'Beginner',
    lectures: 156,
    isBestseller: true,
    whatYouLearn: [
      'Master Python 3 from scratch',
      'Build games, apps and real tools',
      'Work with files, APIs, and databases',
      'Data structures, OOP, decorators',
      'Web scraping with BeautifulSoup',
    ],
  ),
  Course(
    id: 'c003',
    title: 'UI/UX Design Masterclass — Adobe XD & Figma',
    instructor: 'Daniel Walter Scott',
    instructorAvatar: 'DW',
    category: 'Design',
    description: 'Become a UX designer and get hired. Learn user experience, '
        'design thinking, prototyping with Figma and Adobe XD.',
    thumbnail: 'https://images.pexels.com/photos/17683392/pexels-photo-17683392.jpeg?cs=srgb&dl=pexels-mutecevvil-17683392.jpg&fm=jpg',
    price: '399 EGP',
    rating: '4.9',
    students: '54,100',
    duration: '18 hours',
    level: 'Beginner to Intermediate',
    lectures: 124,
    isBestseller: false,
    whatYouLearn: [
      'Design wireframes, prototypes, and mockups',
      'Master Figma and Adobe XD from scratch',
      'Apply UX research and design thinking',
      'Build a professional portfolio',
      'Design for accessibility and mobile-first',
    ],
  ),
  Course(
    id: 'c004',
    title: 'Machine Learning A-Z™ — Hands-On Python & R',
    instructor: 'Kirill Eremenko',
    instructorAvatar: 'KE',
    category: 'Data Science',
    description: 'Learn to create Machine Learning algorithms in Python and R. '
        'From simple linear regression to deep learning.',
    thumbnail: 'https://images.pexels.com/photos/669612/pexels-photo-669612.jpeg?cs=srgb&dl=pexels-goumbik-669612.jpg&fm=jpg',
    price: '499 EGP',
    rating: '4.6',
    students: '210,300',
    duration: '44 hours',
    level: 'Intermediate',
    lectures: 328,
    isBestseller: true,
    whatYouLearn: [
      'Regression, classification, and clustering',
      'Neural networks and deep learning',
      'NLP and computer vision basics',
      'Model evaluation and optimization',
      'Real-world business problem solving',
    ],
  ),
  Course(
    id: 'c005',
    title: 'React Native — Build Mobile Apps with React',
    instructor: 'Maximilian Schwarzmüller',
    instructorAvatar: 'MS',
    category: 'Development',
    description: 'Use React Native and your React knowledge to build native '
        'iOS and Android Apps — incl. Redux, Hooks, CSS Modules.',
    thumbnail: 'https://images.pexels.com/photos/20694602/pexels-photo-20694602.png?cs=srgb&dl=pexels-karub-20694602.jpg&fm=jpg',
    price: '399 EGP',
    rating: '4.8',
    students: '87,400',
    duration: '28 hours',
    level: 'Intermediate',
    lectures: 247,
    isBestseller: false,
    whatYouLearn: [
      'Build native apps for iOS and Android',
      'React Native core components and APIs',
      'Navigation with React Navigation',
      'State management with Redux and Context',
      'Publishing to App Store and Play Store',
    ],
  ),
  Course(
    id: 'c006',
    title: 'AWS Certified Solutions Architect — SAA-C03',
    instructor: 'Ryan Kroonenburg',
    instructorAvatar: 'RK',
    category: 'Cloud',
    description: 'Pass the AWS Solutions Architect Associate exam and learn '
        'real-world cloud architecture skills.',
    thumbnail: 'https://images.pexels.com/photos/17489156/pexels-photo-17489156.jpeg?cs=srgb&dl=pexels-cookiecutter-17489156.jpg&fm=jpg',
    price: '549 EGP',
    rating: '4.7',
    students: '112,600',
    duration: '27 hours',
    level: 'Intermediate to Advanced',
    lectures: 193,
    isBestseller: true,
    whatYouLearn: [
      'EC2, S3, RDS, and VPC architecture',
      'IAM roles and security best practices',
      'High availability and disaster recovery',
      'Serverless with Lambda and API Gateway',
      'Pass the AWS SAA-C03 exam',
    ],
  ),
];

// ── ENROLLED COURSES (Mirna's courses) ───────────────────
// Ch05 — Capability: enrollment = access token
final kEnrolled = [
  {'course': kCourses[0], 'progress': 0.78, 'lastLesson': 'Lecture 14: State Management'},
  {'course': kCourses[1], 'progress': 0.45, 'lastLesson': 'Lecture 8: Functions'},
  {'course': kCourses[2], 'progress': 0.12, 'lastLesson': 'Lecture 2: Design Thinking'},
];

// ── WISHLIST ─────────────────────────────────────────────
final kWishlist = [kCourses[3], kCourses[4], kCourses[5]];

// ── INSTRUCTOR DATA ──────────────────────────────────────
final kInstructors = [
  {
    'name': 'Angela Yu',
    'initials': 'AY',
    'title': 'Lead Instructor at London App Brewery',
    'location': 'London, UK',
    'students': '1,800,000',
    'courses': '72',
    'rating': '4.8',
    'bio': 'Angela Yu is a developer and teacher with a passion for mobile development. '
        'She leads the London App Brewery, London\'s leading programming bootcamp.',
    'color': AppColors.purple,
    'verified': true,
  },
  {
    'name': 'Jose Portilla',
    'initials': 'JP',
    'title': 'Data Science & Python Expert',
    'location': 'New York, USA',
    'students': '980,000',
    'courses': '15',
    'rating': '4.7',
    'bio': 'Jose Portilla has years of professional experience working in data science '
        'and machine learning. He has worked with Fortune 500 companies.',
    'color': AppColors.orange,
    'verified': true,
  },
];

// ── CATEGORIES ───────────────────────────────────────────
const kCategories = [
  {'name': 'All',         'icon': Icons.apps,             'color': AppColors.purple},
  {'name': 'Development', 'icon': Icons.code,             'color': AppColors.dPurple},
  {'name': 'Design',      'icon': Icons.design_services,  'color': AppColors.orange},
  {'name': 'Data Science','icon': Icons.analytics,        'color': AppColors.green},
  {'name': 'Cloud',       'icon': Icons.cloud,            'color': AppColors.gray},
  {'name': 'Business',    'icon': Icons.business,         'color': AppColors.gold},
];
