class Main {

  Vec3D dist = new Vec3D(); // creating the distance vector
  Vec3D loc = new Vec3D(); // creating the location vectpor
  Vec3D locCopy = new Vec3D(); // creating a new vector which will be an copy of the loc vector
  Vec3D rotation; // intializing the rotation vector
  float m; // initializing m
  int ffts; // initializing ffts

    //Constructor
  Main( Vec3D _rotation, int _ffts) {  // the constructor is taking two inputs, a rotation vector and a interger ffts

    rotation = _rotation;
    ffts =_ffts;

    loc = calculate(); // setting the location vector to the calculate vector which gives the sphere its location
    dist.subSelf(loc); // getting the magnitude from the distance vector to the location vector
    dist.normalize(); // normalizing the distance vector to the new unit vector
    locCopy = loc.copy(); // making locCopy to be the same vector as loc
  }

  void display() { 

    strokeWeight(2); // setting the size of the points in the sphere to 2
    point(loc.x, loc.y, loc.z); // drawing all the points using location x, y and z given by the calculate function
    loc = locCopy.copy(); // when the points are drawn they go back to the original position
  }

  void update() {

    m = fft.getBand(ffts); // setting m to be the fft

    float n = noise(map(locCopy.x, 0, 100, 0, 20), // adding noise to the varibale n and mapping it to the all the 3D positions in my location vector
    map(locCopy.y, 0, 100, 0, 20), 
    map(locCopy.z, 0, 100, 0, 20));
    float g = constrain(map(m, n, n-1, -10, 20*n), -20, 60); // setting g to a constrain that is mapped by using fft bands and noise

    dist.normalizeTo(n - g); // normalizing the dist vector to the n - g which will affect the sphere by the fft and noise
    loc.addSelf(dist); // adding the dist vector with the location vector which will make the sphere move to the music
  }

  Vec3D calculate() { 

    pushMatrix(); 
    rotateY(rotation.y); // rotating Y by the rotation vector y-coordinate
    rotateZ(rotation.z); // rotating Z the rotation vector z-coordinate
    float x = modelX(150, 0, 0); // ModelX to Z returns a 3D position for the given coordinate based on the current set of transformations
    float y = modelY(150, 0, 0);
    float z = modelZ(150, 0, 0);    
    popMatrix();

    Vec3D actualLoc = new Vec3D(x, y, z); // creating a new vector with the location taken from modelX, modelY and modelZ
    return actualLoc; // returning the actualloc vector
  }
}

