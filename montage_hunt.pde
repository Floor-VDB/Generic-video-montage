import processing.video.*;

import ddf.minim.*;
Minim minim;

AudioPlayer [] soundee = new AudioPlayer[9];
Movie [] movee = new Movie[12];

IntList movieinventory;
IntList soundinventory;
int chosenvid=0;
int prevvid;
int chosensound=0;
int prevsound;
int timeoffset;
int shotlength;
int soundlength;
int movielength=230000;
int jumpvidtimer=0;

int[][] allvidsinfo = 
  {
  {0, 231160}, 
  {63220, 183160}, 
  {11230, 198090}, 
  {4080, 245060}, 
  {32190, 187010}, 
  {35110, 177120}, 
  {0, 251000}, 
  {7060, 222120}, 
  {0, 241290}, 
  {24250, 221180}, 
  {28110, 184190}, 
  {0, 110200}
};

int[][] allsoundsinfo = 
  {
  {24423, 180196}, 
  {35085, 191408}, 
  {0, 222100}, 
  {32307, 2286419}, 
  {4327, 240417}, 
  {0, 219211}, 
  {0, 230424}, 
  {103257, 230417}, 
  {28090, 230417}
};

void setup() {
  //size(1920, 1080,P2D );
  fullScreen();
  //frameRate(30);
  minim = new Minim(this);

  movee[0] = new Movie(this, "hunting/vid1 0-231160.mov");
  movee[1] = new Movie(this, "hunting/vid2 63220-183160.mov");
  movee[2] = new Movie(this, "hunting/vid3 11230-198090.mov");
  movee[3] = new Movie(this, "hunting/vid4 4080-245060.mov");
  movee[4] = new Movie(this, "hunting/vid5 32190-187010.mov");
  movee[5] = new Movie(this, "hunting/vid6 35110-177120.mov");
  movee[6] = new Movie(this, "hunting/vid7 0-251000.mov");
  movee[7] = new Movie(this, "hunting/vid8 7060-222120.mov");
  movee[8] = new Movie(this, "hunting/vid9 0-241290.mov");
  movee[9] = new Movie(this, "hunting/vid10 24250-221180.mov");
  movee[10] = new Movie(this, "hunting/vid11 28110-184190.mov");
  movee[11] = new Movie(this, "hunting/vid12 0-110200.mov");

  soundee[0] = minim.loadFile("hunting/audio1 24423-190196.mp3");
  soundee[1] = minim.loadFile("hunting/audio2 35085-201408.mp3");
  soundee[2] = minim.loadFile("hunting/audio3 0-231100.mp3");
  soundee[3] = minim.loadFile("hunting/audio4 32307-2406419.mp3");
  soundee[4] = minim.loadFile("hunting/audio5 4327-250417.mp3");
  soundee[5] = minim.loadFile("hunting/audio6 0-229211.mp3");
  soundee[6] = minim.loadFile("hunting/audio7 0-240424.mp3");
  soundee[7] = minim.loadFile("hunting/audio8 103257-250417.mp3");
  soundee[8] = minim.loadFile("hunting/audio9 28090-250417.mp3");

  movieinventory = new IntList();
  soundinventory = new IntList();
  background(#000000);
}

void draw() {
  jumpvidtimer++;
  timeoffset=millis()%movielength;
  //println(timeoffset);

  shotlength = 5000;
  soundlength = 19100;

  if (timeoffset%soundlength>1 && timeoffset%soundlength<20) {
    soundinventory.clear();
    for (int i=0; i<allsoundsinfo.length; i++) {
      if (allsoundsinfo[i][0]<timeoffset && allsoundsinfo[i][1]>timeoffset) {
        soundinventory.append(i);
      }
    }
    prevsound=chosensound;
    int rand = int(random(soundinventory.size()));
    if (rand==prevsound) {
      rand = int(random(soundinventory.size()));
    }
    if (rand==prevsound) {
      rand = int(random(soundinventory.size()));
    }

    //image(movee[chosenvid], 0, 0);

    chosensound = soundinventory.get(rand);
    println(chosensound + " - " + timeoffset +" :playing - stopped: "+prevsound+" - possible vids: " + soundinventory);

    //Play the randomly chosen video & jump to correct time
  soundee[prevsound].pause();
      soundee[chosensound].rewind();

    soundee[chosensound].play();
    soundee[chosensound].skip(timeoffset);

  
  
  }


  // when shotlength is reached do this
  if (timeoffset%shotlength>1 && timeoffset%shotlength<50) {

    // Create array with possible movies

    movieinventory.clear();
    for (int i=0; i<allvidsinfo.length; i++) {
      if (allvidsinfo[i][0]<timeoffset && allvidsinfo[i][1]>timeoffset) {
        movieinventory.append(i);
      }
    }
    prevvid=chosenvid;

    //choose randomly from possible movies 

    int rand = int(random(movieinventory.size()));
    if (rand==prevvid) {
      rand = int(random(movieinventory.size()));
    }
    if (rand==prevvid) {
      rand = int(random(movieinventory.size()));
    }
    //println(rand);
    translate(width/2, height/2);

    imageMode(CENTER);

    image(movee[chosenvid], 0, 0);

    chosenvid = movieinventory.get(rand);
    println(chosenvid + " - " + timeoffset);

    //Play the randomly chosen video & jump to correct time

    movee[chosenvid].play();
    println("played");
    jumpvidtimer=0;

    // Stop previous video if it is different then current one
  }
  //background(#000000);

  translate(width/2, height/2);
  //Print the movie frame in canvas
  imageMode(CENTER);

  if (jumpvidtimer>1) {
    image(movee[chosenvid], 0, 0);
  }

  //println(movee[chosenvid].time());
  //textMode(CORNER);
  //fill(#000000);
  //rect(-200, 280, 500, 900);
  //fill(#ffffff);

  //text("we are at: "+timeoffset/1000+" seconds \nwe are playing video: "+chosenvid+"\npossible vids: " + movieinventory +"\nShotlength: "+shotlength, -100, 300);    
  //fill(#000000);
  //  rect(-600, 280, 500, 900);
  //  fill(#ffffff);

  //  text("we are at: "+timeoffset/1000+" seconds \nwe are playing sound: "+chosensound+"\npossible vids: " + soundinventory +"\nShotlength: "+soundlength, -400, 300);

  if (jumpvidtimer==2) {
    movee[chosenvid].jump((timeoffset-allvidsinfo[chosenvid][0])/1000);
    println("jumped" + (timeoffset-allvidsinfo[chosenvid][0])/1000);
    if (prevvid!=chosenvid) {
      movee[prevvid].stop();
      println(prevvid + "stopped");
    }
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}