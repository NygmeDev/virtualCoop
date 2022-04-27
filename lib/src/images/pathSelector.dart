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
    case "cCStoDomingo":
      path += "CCStoDomingo";
      break;
    case "chunchi":
      path += "Chunchi";
      break;
  }

  return path;
}
