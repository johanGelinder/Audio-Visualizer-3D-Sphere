void options() {

  if (drawSphere == false) {
    dark2 += 10; // when drawSphere is false add 10 each frame to dark2 which is the alpha value of the option text

    fill(100, 0, dark2); // white text that uses dark2 to fade in
    textSize(24); // setting the text size to 24
    text("Press the S key to switch state and", width/2, height/2-15); // displaying the option text
    text("  press the R key to switch back to the first state", width/2-10, height/2+15);
  }

  if ( dark2 >= 2400 ) { // when dark2 reaches 2500 then go into state 1 which is the first audio visualizer  
    state = 1;  
  }
}

