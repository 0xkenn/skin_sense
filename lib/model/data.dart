class SkinRecommendation {
  final String name;
  final List<String> dos;
  final List<String> donts;
  final List<String> dayIngredients;
  final List<String> nightIngredients;

  SkinRecommendation({
    required this.name,
    required this.dos,
    required this.donts,
    required this.dayIngredients,
    required this.nightIngredients,
  });
}

List<SkinRecommendation> skinTypeInfo = [
  SkinRecommendation(
    name: 'normal',
    dos: [
      'Cleanse your face',
      'Use a Serum with Antioxidants',
      'Moisturize your face',
      'Wear SPF'
    ],
    donts: ['Use Harsh Products', 'Over-Hydrate', 'Lack Consistency'],
    dayIngredients: [
      'VITAMIN C',
      'Retinol',
      'Niacinamide',
      'Hyaluronic acid',
      'Ceramides',
      'Salicylic acid',
      'Benzoyl peroxide',
      'Glycolic acid',
      'Lactic acid',
      'Vitamin E',
      'Green tea',
      'Cocoa extract',
      'Blueberry extract'
    ],
    nightIngredients: [
      'Retinol',
      'Hyaluronic acid',
      'Ceramides',
      'Niacinamide'
    ],
  ),
  SkinRecommendation(
    name: 'dry',
    dos: [
      'Take a short, warm shower.',
      'Use a moisturizer that is oil-based.',
      'Cleanse gently',
      'Use a non-soap liquid cleanser when you shower.',
      'Always shave with shaving cream or gel',
      'Do wash gently',
      'Do drink your H2O.',
      'Do moisturize twice a day.'
    ],
    donts: [
      'Avoid using hot water when you shower.',
      'Avoid moisturizers that are water-based.',
      'Avoid overusing toners, peels and other astringents that contain alcohol.',
      'Avoid leaving your heater on.',
      "Don't wash twice a day.",
      "Don't use products with fragrances"
    ],
    dayIngredients: [
      'Hyaluronic acid',
      'Glycerin',
      'Ceramides',
      'Shea Butter',
      'Lactic acid',
      'SQUALANE',
      'Aloe vera',
      'Avocado oil',
      'Vitamin E',
      'Urea',
      'Petroleum Jelly',
      'Pataua Oil',
      'Panthenol'
    ],
    nightIngredients: ['Shea Butter', 'Glycerin', 'Ceramides'],
  ),
  SkinRecommendation(
    name: 'oily',
    dos: [
      'Do wash your face every day and night',
      'Use non-comedogenic products',
      'Always moisturize your face.',
      'Always wear sunscreen',
      'Exfoliate weekly',
      'Use blotting papers throughout the day.',
      'Do use a gentle, foaming face wash.'
    ],
    donts: [
      'Don’t touch your face throughout the day.',
      'Don’t over wash your face.',
      'Avoid heavy make-up.',
      "Don't overmedicate."
    ],
    dayIngredients: [
      'Niacinamide',
      'Salicylic Acid',
      'Hyaluronic Acid',
      'Retinol',
      'Tea Tree Oil',
      'Aloe Vera',
      'Zinc',
      'Glycolic acid'
    ],
    nightIngredients: ['Salicylic Acid', 'Tea Tree Oil', 'Niacinamide'],
  ),
  SkinRecommendation(
    name: 'acne',
    dos: [
      'Do Cleanse Gently',
      'Do Use Sun Protection',
      'Do Use Soothing Techniques',
      'Do Try Over The Counter Help',
      'Do Seek Professional Advice',
      'DO use a mild non-abrasive cleanser'
    ],
    donts: [
      'DON’T cover or conceal acne with cosmetics',
      'DON’T over examine your skin'
    ],
    dayIngredients: [
      'Benzoyl peroxide',
      'Salicylic acid',
      'Niacinamide',
      'Alpha hydroxy acids',
      'Sulfur',
      'Adapalene',
      'Azelaic acid',
      'Vitamin C',
      'Tea tree oil',
      'Kaolin clay'
    ],
    nightIngredients: ['Benzoyl Peroxide', 'Retinol', 'Adapalene'],
  ),
  SkinRecommendation(
    name: 'combination',
    dos: [
      'Mix up your products',
      'Exfoliate regularly',
      'Keep changing your skincare routine',
      'Do pick products for your skin type.',
      'Do divide and conquer',
      'Try a Targeted Approach to Product Application',
      'Focus on Long-Term Hydration',
      'Choose Active Ingredients That Suit Your Skin Type'
    ],
    donts: [
      'Skip moisturizer.',
      'Forget to use a toner',
      "Don't forget to exfoliate",
      "Don't get stuck in a rut",
      "Go Overboard Trying to Control Oil.",
      "Use Heavy Products"
    ],
    dayIngredients: [
      'Lactic Acid',
      'Bentonite Clay',
      'Hyaluronic Acid',
      'Seaweed',
      'Squalane',
      'Sunflower Oil',
      'Jojoba Oil',
      'Mango Butter',
      'Vitamin C',
      'Niacinamide',
      'Aloe Vera Gel',
      'Green Tea',
      'Azelaic Acid',
      'Tea Tree Oil'
    ],
    nightIngredients: ['Retinol', 'Hyaluronic Acid', 'Niacinamide'],
  ),
  SkinRecommendation(
    name: 'unknown',
    dos: ['N/A'],
    donts: ['N/A'],
    dayIngredients: ['N/A'],
    nightIngredients: ['N/A'],
  ),
];
