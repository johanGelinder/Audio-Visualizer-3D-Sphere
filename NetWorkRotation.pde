void netRot() {

  float rotx = PI/4; // creating my rotation on the x and y-axis by dividing PI with 4
  float roty = PI/4;

  rotateY(frameCount /400.0); // automatic rotation around the Y-axis
  rotateX(rotx); // calling the x and y-axis rotation
  rotateY(roty);
}

