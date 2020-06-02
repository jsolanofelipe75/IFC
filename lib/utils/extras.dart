class Extras{

  static fromNow(DateTime dateTime){

    final DateTime currentDate = DateTime.now();

    final int misn = currentDate.difference(dateTime).inMinutes;

    if(misn<60){
      return 'Publicado hace $misn min.';

    }else if(misn > 60 && misn <= 60 * 23){
      return 'Hace ${(misn / 60 ).ceil()} h.';

    }else if(misn > 60 * 23 && misn < 60 * 24 * 4){
      return 'Publicado hace ${(misn / (60 * 24) ).ceil()} días.';
    }else{

      return 'Publicado el ${dateTime.day}/${dateTime.month}/${dateTime.year}';

    }

  }
}