void playButton() {

  noStroke();
  fill(100, 0, a3/2); // filling the rectangle white with a low brighnetss value to make it look transparent
  rect(width/2, 100, 200, 100, 7); // drawing a rectangle with rounded corners
  tint(100, 0, 100, dark-20); // the tint function is used for fading out the image when the play button is clicked
  image(play, width/2, 105); // displaying the play image

  if ( mouseX > 550 & mouseY > 50 && mouseX < 750 && mouseY < 150) { // if the user hover over the button make this happen
    noStroke(); // calling noStroke on the rectangle
    fill(100, 0, a4); // filling the rectangle with a higher alpha value so it lights up
    rect(width/2, 100, 200, 100, 7); // drawing the same size rectangle over the other rectangle
    tint(100, 0, 100, dark-20); // same fade out effect if the user holds the mouse on the button
    image(play, width/2, 105); // displaying the same image on top of the other image
  }
}

