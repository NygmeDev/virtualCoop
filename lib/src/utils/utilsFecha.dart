daysToYear(int days){
  return (days/365).truncate();
}

daysToMonth(int days){
  final diasAnios = daysToYear(days)*365;
  return days > diasAnios ? ((days-diasAnios)/30).truncate() : ((days)/30).truncate();
}

diasRestantes(int days){
  final diasAnios = daysToYear(days)*365;
  return days > diasAnios ? days - diasAnios : days; 
}