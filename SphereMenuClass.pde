class MenuSphere { // menuSphere

  Vec3D dist2 = new Vec3D(); // creating the distance vector
  Vec3D loc2 = new Vec3D(); // creating the location vector
  Vec3D rot2; // intializing the rotation vector
  float m; // initializing m
  int ffts; // initializing ffts

  //Constructor
  MenuSphere( Vec3D _rot2) { // the constructor is taking one input which is a rotation vector

    rot2 = _rot2;

    loc2 = calculate2(); // setting the location vector to the calculate vector which will give the sphere its location
    dist2.subSelf(loc2); // getting the magnitude from the distance vector to the location vector
    dist2.normalize(); // normalizing the distance vector to the new unit vector
  }

  void display() { 

    strokeWeight(2); // setitting strokeWeight to 2
    point(loc2.x, loc2.y, loc2.z); // drawing all the points using location x, y and z 
  }

  void update() {

    float n2 = noise(map(loc2.x, 0, 200, 0, 10), // adding noise to the varibale n and mapping it to the all the 3d positions in my location vector
    map(loc2.y, 0, 200, 0, 10), 
    map(loc2.z, 0, 200, 0, 10));

    if (start) { // starts the animation when the play button is clicked
      dist2.normalizeTo(n2);  // normalizing the dist2 vector to the n2 which will give the sphere a cool noise effect when it starts animating
      loc2.addSelf(dist2); // adding the dist2 vector to the location vector which will makes it compress towards the middle

      if (a2 == -1300) { // when a2 goes down to -1300 then start fading out the menu sphere
        sphereFade = true;
      }
      if (a2 == -1500) { // then when a2 reaches -1500 stop drawing the sphere and activate the options text
        drawSphere = false;
      }
    }
  }

  Vec3D calculate2() { 

    pushMatrix(); 
    rotateY(rot2.y); //rotating by the rotation vector y coordinate
    rotateZ(rot2.z); // rotating y the rotation vector z coordinate
    float x2 = modelX(150, 0, 0); // ModelX to Z returns a 3D position for the given coordinate based on the current set of transformations
    float y2 = modelY(150, 0, 0);
    float z2 = modelZ(150, 0, 0);      
    popMatrix();

    Vec3D actualLoc2 = new Vec3D(x2, y2, z2); // crearing a new vector with the location taken from modelX to Z
    return actualLoc2; // returning the actualLoc2 vector
  }
}

