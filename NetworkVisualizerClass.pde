class Net {

  int maxspeed = 2;  // setting the max speed
  float r, m; // initializing the floats r and m

  Vec3D loc = new Vec3D(); // creating a location vector
  Vec3D vel = new Vec3D(random(-1, 1), random(-1, 1), random(-1, 1)); // creating a velocity vector
  Vec3D acceleration = new Vec3D(); // creating a acceleration vector

  // CONSTRUCTOR
  Net(Vec3D _loc) { // the constructor is taking one input which is a location vector

    loc = _loc; // the vector location will be visiable
  }

  void run() { // creating a run function which calls all the other functions in the class

    display(); // this function draws all the points
    update(); // this function updates the network
    screen(); //this function checkes for the edges 
    lines(); // this functions draws lines between all the points
    separate(10); // this function separates all the elements from each other and the magnitude is set here in the function
  }

  void separate(float magnitude) { 

    Vec3D direction = new Vec3D(); // Creating a new empty direction vector 
    
    for (int i = 0; i < network.size (); i ++) { // go through all the points in the network arraylist
      Net other = (Net) network.get(i); // getting all the points and storing them in other

      float distance = loc.distanceTo(other.loc); // calculating the distance between the two vectors loc and other 

      if ( distance > 0 && distance < 20) { // if the distance between the points is between 0 to 20 
        Vec3D diff = loc.sub(other.loc); // getting the subtraction between the location and the other location
        diff.normalizeTo(1.0/distance); // normalizing to smoother out the separation depending on the distance 
        direction.addSelf(diff); // adding the diff vector to the direction vector which will move the points in the opposite direction from each other if the distance between them is between 0 and 20
      }
    }

    direction.scaleSelf(magnitude); // magnitude modifies our scaling on the direction vector
    acceleration.addSelf(direction); // adding the direction vector to the acceleration vector
  }

  void update() {

    vel.addSelf(acceleration); // adding the acceration vector to the vel vector
    vel.limit(maxspeed); // limits the vel to 4 as or maximum velocity
    loc.addSelf(vel); // adding the vel vector to the location vector for every frame
    acceleration.clear(); // reset the acceleration
  }

  void screen() { // checking if the points hits the edges and if they do then reverse their velocity

    if ( loc.x > width-200 || loc.x < 200) {
      vel.x = vel.x * -1;
    }
    if ( loc.y > height || loc.y < 0) {
      vel.y = vel.y * -1;
    }
    if ( loc.z < - height || loc.z > 0) {
      vel.z = vel.z * -1;
    }
  }

  void lines() { // connects lines between all the elements if they are within a specific range

    for (int i = 0; i < network.size (); i ++) { // go through all the element in network arraylist
      Net other = (Net) network.get(i); // this gives me every element in network

      float distance = loc.distanceTo(other.loc); // calculating the distance between the all the point 

      if ( distance > 0 && distance < 160) { // if the distance is between 0 and 160 then you draw a line

        stroke(100, 0, AlphaLine); // setting the stroke of the lines to white and the alpha value to a max value of 50
        strokeWeight(0.4); // setting the thickness of the lines to 0.4
        line(loc.x, loc.y, loc.z, other.loc.x, other.loc.y, other.loc.z); // draws a lines between between points in 3D space
      }
    }
  }

  void display() { 

    for (int i = 0; i < 100; i ++ ) {
      m = fft.getBand(i); // storing the fft in the variable m

      float n = noise(map(loc.x, 0, 50, 0, 10), // adding noise to the varibale n and mapping it to the all the 3d positions in my location vector
      map(loc.y, 0, 200, 0, 10), 
      map(loc.z, 0, 200, 0, 10));
      //float g = constrain(map(m, n, n, 10, 100), 4, 15); // setting g to a constrain that is mapped by using fft bands and noise
      strokeWeight(loc.z/50*m); // setting the size of the points in the network to the Z-location which creates an effect that they are bigger on one side
    }

    stroke(netAlpha2); // setting the stoke of the points to a maximum value of 100 (full white)
    point(loc.x, loc.y, loc.z); // drawing the points at loc's x, y and z position
  }
}