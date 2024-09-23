int getIndex(String skinIndex) {
  final skinType = skinIndex;

  switch (skinType) {
    case 'normal':
      return 0;
    case 'dry':
      return 1;
    case 'oily':
      return 2;
    case 'acne':
      return 3;
    case 'combination':
      return 4;
    default:
      return 0;
  }
}
