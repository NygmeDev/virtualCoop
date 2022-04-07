String pathSelector(String token) {
  var path = "assets/logosVirtualCoop";

  switch (token) {
    case "lasNaves":
      path += "LasNaves";
      break;
    case "solAndes":
      path += "SolAndes";
      break;
    case "ciudadZamora":
      path += "CiudadZamora";
      break;
  }

  return path;
}
