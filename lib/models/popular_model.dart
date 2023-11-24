class PopularDietsModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool boxIsSelected;

  PopularDietsModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxIsSelected
  });

  static List < PopularDietsModel > getPopularDiets() {
    List < PopularDietsModel > popularDiets = [];

    popularDiets.add(
      PopularDietsModel(
       name: 'Steve Ndicunguye',
       iconPath: 'https://lh3.googleusercontent.com/a/AGNmyxbsEy7JSTGCaqtDN6xBs9LmnTU7ngsaQFeJOmFz=s96-c',
       level: 'ndicunguyesteve4@gmail.com',
       duration: '30mins',
       calorie: '230kCal',
       boxIsSelected: true,
      )
    );

    popularDiets.add(
      PopularDietsModel(
       name: 'Emmanuel Nkubito',
       iconPath: 'https://lh3.googleusercontent.com/a/AGNmyxbsEy7JSTGCaqtDN6xBs9LmnTU7ngsaQFeJOmFz=s96-c',
       level: 'nkubitoemmanuel@gmail.com',
       duration: '20mins',
       calorie: '120kCal',
       boxIsSelected: false,
      )
    );

    return popularDiets;
  }
}