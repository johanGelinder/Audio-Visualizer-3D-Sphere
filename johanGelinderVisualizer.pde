//Audio Visualizer by Johan Gelinder
//Music by Johan Gelinder and Gustaf Svennungsson

// Importing ToxicLibs library
import toxi.processing.*;
import toxi.geom.*;

//Importing Minim library
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim; // initalizing Minim
AudioPlayer player; // initialzing the AudioPLayer
FFT fft; // initializing the fft 

MenuSphere point; // initalizing the MenuSphere class
MenuSphere [] sphereMenu; // initalizing the array of points for the menu sphere

Main visual; // initalizing Main visual class
Main [] points; // initalizing the array of points for the sphere visualizer

ArrayList network; // initializing the arraylist network
float AlphaLine = 0;  // the alpha (brightness) value of the lines in the network
float netAlpha2 = 0;  // the alpha value of the network points
int state = 0; // initializing the states and setting it to 0
int Nums = 3000; // the number of points in the spheres
boolean drawSphere = true; // when drawSphere is true the menu sphere is drawn 
boolean sphereFade = false; // when this is true the sphere will fade out
boolean start = false; // this is called when you press play
float a = 60; // alpha values that is used for fade in and out
float a2 = 60; 
float a3 = 60;
float a4 = 80;
float dark = 100;
float dark2 = 0;
float SphereAlpha = 0; 
PImage play, sign; // initializing the PImages for the menu

void setup()
{ 

  size(1300, 800, P3D); // making my canvas 800X800 and also rendering the sketch in 3D
  colorMode(HSB, 100); // setting colorMode to HSB and changing it to max value of 100
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  minim = new Minim(this); // creating Minim
  player = minim.loadFile("menu_music.mp3"); // loading the audio file
  fft = new FFT(player.bufferSize(), player.sampleRate()); // setting the fft 
  fft.logAverages(8, 3); // Sets the number of averages used when computing the spectrum based on the minimum bandwidth for an octave and the number of bands per octave
  play = loadImage("play.png"); // loading the play button image
  sign = loadImage("sign.png"); // loading the signature image

  /* -------------- Menu Sphere Setup --------------- */

  sphereMenu = new MenuSphere[Nums]; // creating the array with 3000 points
  for (int i = 0; i < sphereMenu.length; i++) {// going through all the points in the array

    Vec3D rot = new Vec3D(0, (PI*i -floor(PI*i)) * 4*PI, asin(2*i/(float)sphereMenu.length-1));  // creating a rotation vector for the menu sphere
    sphereMenu[i] = new MenuSphere(rot); // passing the rotation of all the points in the SphereMenu array through the contructor class
  }

  /* ------------- Sphere Visualizer Setup ---------------- */

  points = new Main[Nums]; // creating the array with 3000 points
  for (int i = 0; i < points.length; i++) // going through all the points in the array
  {
    Vec3D rotation = new Vec3D(0, (PI*i -floor(PI*i)) * 4*PI, asin(2*i/(float)points.length-1));  // creating a rotation vector for the visualizer 
    points[i] = new Main(rotation, i%300); //passing the rotation and fft of all the points through the conctructor class
  }

  /* --------------Network Visualizer Setup ----------- */

  network = new ArrayList(); // creating the ArrayList network
  for (int i = 0; i < 160; i++) { // going through the array that has 160 points for the network
    Vec3D orgin = new Vec3D(width/2, height/2, -height/2); // the point where the network will spawn which is the middle of the screen
    Net newNet = new Net(orgin); // passing the location vectpr orign through the constructor in the class
    network.add(newNet); // adding all the points to the arrayLsist
  }

  player.play(); // playing the audio file
  player.loop(); // looping the audio file
}

void draw()
{ 

  background(0); // calling the background and setting it to black
  fft.forward(player.mix); // mixing the fft so you have a mix between left and right

  /* -------------------------------- MENU SPHERE -----------------------------------------------  */

  switch( state ) {

  case 0:  // state 0 is the menu screen

    playButton(); // calling the function with the play button
    signature(); // calling the function with the signature image and text
    pushMatrix();
    translate(width/2, height/2, 0); // translating to the middle of the screen
    float rotateY = mouseX * TWO_PI / width; // rotating the menu sphere by using the mouse
    float rotateX = mouseY * TWO_PI / height;
    rotateY(rotateY); // calling the rotations on the X and Y-axis
    rotateX(rotateX);

    if (drawSphere) {

      for (int i=0; i < sphereMenu.length; i++) // going through all of the points in the array to draw the menu sphere
      { 

        float col = map(i, 100, sphereMenu.length, 10, 100); // maping the colour for the sphere to get a nice colour transition
        stroke(80, col, a); // setting the colour of the sphere
        sphereMenu[i].update(); // updating all the points 
        sphereMenu[i].display(); // displaying the menu sphere
      }
    }
    popMatrix();
    menuFade(); // calling the function that will fade out the buttons and text when the the user press play
    options(); // calling the function that will display the options menu when the sphere disapears

      break;

    /* ------------------- SPHERE VISUALIZER ---------------------------------------------- */

  case 1: // state 1 is the Sphere visualizer

    pushMatrix();    
    SphereAlpha += 0.3; // when state 1 is called start fading in the sphere

    if ( SphereAlpha >= 60) { // when SphereAlpha is greater or equal to 60 then stop it from increasing
      SphereAlpha = 60; // setting SphereAlpha to the final value of 60
    }  

    translate(width/2, height/2, 0); // translating to the middle of the screen
    rotateY(frameCount /200.0); // automatic rotation around thr X and Y-axis
    rotateX(frameCount /200.0);

    for (int i=0; i<points.length; i++) // going through all of the points in the array
    { 
      float col = map(i, 100, points.length, 10, 100); // maping i between 100 and the number of points so that I can use that to make a nice fade effect on the sphere
      stroke(80, col, SphereAlpha); // setting the stroke to all the points
      points[i].update(); // updating all the points 
      points[i].display(); // displaying the sphere visualizer
    }
    popMatrix();

    break;

    /* --------------------------------- NETWORK VISUALIZER -------------------------------------------------- */

  case 2: // state 2 is the network visualizer

    AlphaLine += 0.2; // when state 2 is equal to true, then start increasing the alpha values for the points and the lines by 0.2 per frame which will make it fade in every time it's called
    netAlpha2 += 0.2;

    if ( AlphaLine >= 50) { // when AlphaLine is greater or equal to 50 then stop the AlphaLine at the max value 50
      AlphaLine = 50;
    }
    if (netAlpha2 >= 100) {  // when netAlpha2 is greater or equal to 100 then stop the netAlpha at the max value 100
      netAlpha2 = 100;
    }

    pushMatrix();
    translate(width/2, -height/2, -450); // setting a new translation for the rotation of the network to look as good as possible
    netRot(); // calling the network rotation function
    for ( int i = 0; i < network.size (); i ++) { // looping through the ArrayList
      Net drawNet = (Net) network.get(i); // getting all the elements inside the ArrayList
      drawNet.run(); // drawing the network visualizer
    }
    popMatrix();

    break;
  }
}

void mousePressed() {

  if ( mouseX > 550 & mouseY > 50 && mouseX < 750 && mouseY < 150) { // checking that the mouse is within the play button when clicked
    start = true; // starting the animation on the menu sphere
  }
}

void keyPressed() { // when the user is in sate 1 you can click on 'S' to change state and by clicking on 'R' in state 2 the user goes back to the first state

  if (state == 1) { // if you're in state 1 and press S you switch to state 2 
    if (key == 's') {
      state = 2;
      AlphaLine = 0; // setting both alpha values to 0 for it to fade in every time you switch state
      netAlpha2 = 0;
      SphereAlpha = 0; // setting SphereAlpha back to zero so it ready to fade in next time sate 1 is called
    }
  }

  if (state == 2) { // if you're in state to and press R then you go back to state 1
    if (key == 'r' ) {
      state = 1;
    }
  }
}

