void signature() { 

  tint(100, 0, 100, dark);  // by using the tint function I can create a fade out effect on the image
  image(sign, width/2, 680); // displaying the signature image
  textSize(16); // setting the text size to 16
  fill(100, 0, a2); // white text with a apha value of a2 so that the text can be faded out
  text("Johan Gelinder", width/2, 730); // displaying the text
  text("2015", width/2, 750);
}


