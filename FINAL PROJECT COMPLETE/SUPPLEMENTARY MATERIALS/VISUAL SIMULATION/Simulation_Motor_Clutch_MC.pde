//Barituziga Banuna
//CHEME 7770 Final Project
//May 16 2020


//Parameter Space
int events = 100000;
int i = 0;
int s = 4; //Stiffness Set Number
int nc = 50; //number of molecular clutches
int runtime = 200;

int nm = 50; //number of myosin motors
int Fm = -2; //Motor stall force in pN
int vu = -120; //unloaded motor velocity in nm/s
float kon = 0.3; //On rate constant in 1/s
float koff = 0.1; //Off rate constant in 1/s
float Fb = -2.0; //Bond rupture force in pN
float Kc = 0.8; //Clutch spring constant in pN/nm
int gain = 0; //gain of feedback loop

//Drawing Parameter Space
int c_x = 2;
int c_y = 50;
int ab_y = 50;
int sub_y = 20;
float num = 40/(pow((s+2),2));//(10/121)*pow(s-11,2);
float scaling = num;

float[] Force = new float[events];

//Variable Space
float[] xsub;
float[] xc_clutches;
String S = str(s);
String[] Xc = new String[nc];
float[] xc_values = new float[nc];

//int[] ClutchWidth = new int[events];
//int[] ClutchHeight = new int[events];


//------------------------------------------------------------------------------------

void setup() {
  fullScreen();
  // Load text file as a String
  String[] Xsub = loadStrings("XSUB_"+S+".txt");
  
  // Convert string into an array of integers using ',' as a delimiter
  xsub = float(split(Xsub[0], ' '));

  //Conver string into an array
  for (int c = 1; c<=nc; c++) {
    String C = str(c);
    
    String[] testarray = loadStrings("XC_"+S+"_"+C+".txt");
    Xc[c-1] = testarray[0];
    
    float[] testvalues = float(split(Xc[c-1], ' '));
    xc_values[c-1] = testvalues[c-1];
    
    //ClutchWidth[c-1] = width-(c-1)*(c_x+8)+int(xsub[i]/scaling);
    //ClutchHeight[c-1] = int((height/2)-1.2*ab_y);
  }
  
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
 
  fill(255);//sets the Substrate filling
  rect(width, height/2, int(xsub[i]/scaling)-500, sub_y);// Substrate
  
  fill(100);//sets the Actin filling
  rect(0, (height/2)-80, width, sub_y-10);// F-Actin

  fill(200);//sets Myosin filling
  //stroke(200);
  //rotate(PI/3.0);
  ellipse(150,(height/2)-(102+sub_y)+10*pow(-1,i),sub_y+30, sub_y+40);
  //ellipse(150,(height/2)-(112+sub_y)+15*pow(-1,i),sub_y+30, sub_y+40);
  //ellipse(150,(height/2)-(112+sub_y)+10*pow(-1,i),sub_y+30, sub_y+40);
  //ellipse(150,(height/2)-(112+sub_y)+5*pow(-1,i),sub_y+30, sub_y+40);
  
  rect(0, (height/2)-(122+sub_y), 150+15, sub_y-5);
  
  ellipse(170,(height/2)-(102+sub_y)-10*pow(-1,i),sub_y+30, sub_y+40);
  //ellipse(170,(height/2)-(112+sub_y)-15*pow(-1,i),sub_y+30, sub_y+40);
  //ellipse(170,(height/2)-(112+sub_y)-10*pow(-1,i),sub_y+30, sub_y+40);
  //ellipse(170,(height/2)-(112+sub_y)-5*pow(-1,i),sub_y+30, sub_y+40);
  
  for (int b = 0; b<runtime;b++) {
    for (int f = 0; f<nc; f++) {
      
      //print(xc_values[f]);
      //print(ClutchWidth[f]);
      
      //Force = Kc*(xc-xsub)
      //Force[b] = Kc*(xc_values[f]-xsub[i])/100;
      //if (b == 5 & f == 24){
      //  print(255/(int(Force[20])+1));
      //}
      //stroke(255/(int(Force[50])+1), 255 , 0);
      //fill(255, int(255*log(abs(xc_values[f])))/100, 0);

      //rect(ClutchWidth[b],ClutchHeight[b], c_x, c_y);
      rect(width-f*(c_x+8)+int(xsub[i]/scaling), (height/2)-1.2*ab_y, c_x, c_y);
      
    }

 
  }
  //saveFrame("output/####_S4.png"); //Saves the output for export

  i = i+1;
  //noLoop();

}
