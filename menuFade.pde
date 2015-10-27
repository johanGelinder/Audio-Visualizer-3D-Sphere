void menuFade() {

  if (start) { // when the user press play the alpha values starts going down and fading the menu out
    a2 -= 2;
    a3 -= 2;
    a4 -= 4;
    dark -= 4;
  }

  if ( sphereFade) {  // when sphereFade is equal to true then start fading out the sphere by decreasing the alpha value a with -0.5
    a -= 0.5;
  }
}

