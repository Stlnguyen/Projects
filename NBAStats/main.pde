PImage court;
ArrayList<Double> ballX,ballY,ballH,player1X, player1Y, player2X , player2Y, player3X , player3Y, player4X, player4Y, player5X, player5Y, player6X, player6Y , player7X, player7Y, player8X, player8Y, player9X, player9Y, player10X, player10Y;
ArrayList<Double> distanceFromBallSelected;
int time = 0;
float sliderLeftBoundary = 630, sliderRightBoundary = 830, sliderTopBoundary = 585, sliderBottomBoundary = 635;
float sliderLeftX=615, sliderRightX=660, sliderTopY=585, sliderBottomY=635;
boolean animate = false;
String games[] = {"0041400101","0041400102","0041400103","0041400104","0041400105","0041400106","0041400111","0041400112","0041400113","0041400114","0041400121","0041400122","0041400123","0041400124","0041400125","0041400126","0041400131","0041400132","0041400133","0041400134","0041400141","0041400142","0041400143","0041400144","0041400151","0041400152","0041400153","0041400154","0041400155","0041400161","0041400162","0041400163","0041400164","0041400165","0041400166","0041400167","0041400171","0041400172","0041400173","0041400174","0041400175","0041400201","0041400202","0041400203","0041400204","0041400205","0041400206","0041400211","0041400212","0041400213","0041400214","0041400215","0041400216","0041400221","0041400222","0041400223","0041400224","0041400225","0041400226","0041400231","0041400232","0041400233","0041400234","0041400235","0041400236","0041400237","0041400301","0041400302","0041400303","0041400304","0041400311","0041400312","0041400313","0041400314","0041400315","0041400401","0041400402","0041400403","0041400404","0041400405","0041400406"};
int gamesIterator,eventIterator;
int numberOfEvents;
int teamNumber;
String teamids[] = {"1610612737","1610612738","1610612739","1610612740","1610612741","1610612742","1610612744","1610612745","1610612746","1610612749","1610612751","1610612757","1610612759","1610612761","1610612763","1610612764"}, teamNames[] = {"Atlanta Hawks","Boston Celtics","Cleveland Cavaliers","New Orleans Pelicans","Chicago Bulls","Dallas Mavericks","Golden State Warriors","Houston Rockets","Los Angeles Clippers","Milwaukee Bucks","Brooklyn Nets","Portland Trail Blazers","San Antonio Spurs","Toronto Raptors","Memphis Grizzlies","Washington Wizards"};
int homeTeamIterator, awayTeamIterator;
int selectedPlayer = -1;
String selectedPlayerID = "", selectedPlayerFirstName = "", selectedPlayerLastName = "";
int selectedPlayerJerseyNum = 0;
int distanceIterator;
boolean typeGame = false, typeEvent = false;
String gameString = "";
PImage homeTeamImage = null;PImage awayTeamImage = null; PImage selectedPlayerImage = null;
double[] totalDistanceTraveled = {0,0,0,0,0,0,0,0,0,0};
double maxDistanceTraveled = 0;
String score = "";
String prevScore = "";


void setup() {
  size(1000,1000);
  court = loadImage("data2/court.jpg");
  eventIterator = 0;
  strokeWeight(2);
  PFont myFont = createFont("Georgia", 32);
  textFont(myFont);
  loadDataLines();
}

//Initialize/Update the data
void loadDataLines(){
  //Reorganize the events into an arrayList
  java.io.File folder = new java.io.File("data/games/"+games[gamesIterator]);
  String[] filenames = folder.list();
  ArrayList<String> filenames1 = new ArrayList<String>();
  ArrayList<Integer> filenames2 = new ArrayList<Integer>();
  for (int i = 0; i < filenames.length; i++) {
    filenames1.add(filenames[i]);
  }
  for (int i = 0; i < filenames1.size();i++) {
    filenames2.add(Integer.parseInt(filenames1.get(i).replaceAll("\\D", "")));
  }
  
  for (int i = 0; i < filenames2.size(); i++) {

    for (int j = filenames2.size() - 1; j > i; j--) {
        if (filenames2.get(i) > filenames2.get(j)) {

            int tmp = filenames2.get(i);
            filenames2.set(i,filenames2.get(j));
            filenames2.set(j,tmp);

        }

    }

}

  numberOfEvents = filenames2.size();
  score = "";
  String hi = "";
  String scoreLines[] = loadStrings("http://stats.nba.com/stats/playbyplay?GameID="+games[gamesIterator]+"&StartPeriod=0&EndPeriod=14");
  String scoreLine[] = scoreLines[0].split(",");
  for (int i =0 ; i<scoreLine.length-11;i++)
  {
   if (scoreLine[i].substring(0,1).equals("[") && scoreLine[i+1].equals(Integer.toString(filenames2.get(eventIterator)))){
     score = scoreLine[i+10];
   }
  // if (scoreLine[i].substring(0,1).equals("["))
  //   System.out.println(scoreLine[i+1]);
  }
  
    distanceFromBallSelected = new ArrayList<Double>();
    distanceIterator =0;
  String lines[] = loadStrings("data/games/"+games[gamesIterator]+"/" +filenames2.get(eventIterator)+".csv");
  ballX = new ArrayList<Double>(); ballY = new ArrayList<Double>();ballH = new ArrayList<Double>();player1X = new ArrayList<Double>();player1Y = new ArrayList<Double>();player2X = new ArrayList<Double>();player2Y = new ArrayList<Double>();player3X = new ArrayList<Double>();player3Y = new ArrayList<Double>();player4X = new ArrayList<Double>();player4Y = new ArrayList<Double>();player5X = new ArrayList<Double>();player5Y = new ArrayList<Double>();player6X = new ArrayList<Double>();player6Y = new ArrayList<Double>();player7X = new ArrayList<Double>();player7Y = new ArrayList<Double>();player8X = new ArrayList<Double>();player8Y = new ArrayList<Double>();player9X = new ArrayList<Double>();player9Y = new ArrayList<Double>();player10X = new ArrayList<Double>();player10Y = new ArrayList<Double>();
  String homeTeam = "",awayTeam = "";
  
  for(int i = 0; i <lines.length;i=i+11)
  {
    String[] ballLineCheck = lines[i].split(",");
    if (Integer.parseInt( ballLineCheck[1] ) != -1)
    {
      i--;
    }
    //Acquire all the lines of one time event.
    String[] ballLine = {"0","0","0","0","0","0"};
    if (Integer.parseInt( ballLineCheck[1]) ==-1) {
      ballLine = lines[i].split(",");
    }
    //ballLine = lines[i].split(",");
    String[] player1Line = lines[i+1].split(",");
    String[] player2Line = lines[i+2].split(",");
    String[] player3Line = lines[i+3].split(",");
    String[] player4Line = lines[i+4].split(",");
    String[] player5Line = lines[i+5].split(",");
    String[] player6Line = lines[i+6].split(",");
    String[] player7Line = lines[i+7].split(",");
    String[] player8Line = lines[i+8].split(",");
    String[] player9Line = lines[i+9].split(",");
    String[] player10Line = lines[i+10].split(",");

    
    //Add the X and Y coordinates of all the players at time t, and insert into array at position t
    ballX.add(Double.parseDouble( ballLine[3] ));ballY.add(Double.parseDouble( ballLine[4] ));ballH.add(Double.parseDouble( ballLine[5] )); player1X.add(Double.parseDouble ( player1Line[3] ));
    player1Y.add(Double.parseDouble ( player1Line[4] ));player2X.add(Double.parseDouble ( player2Line[3] ));player2Y.add(Double.parseDouble ( player2Line[4] )); player3X.add(Double.parseDouble ( player3Line[3] ));player3Y.add(Double.parseDouble ( player3Line[4] ));player4X.add(Double.parseDouble ( player4Line[3] ));player4Y.add(Double.parseDouble ( player4Line[4] ));player5X.add(Double.parseDouble ( player5Line[3] ));player5Y.add(Double.parseDouble ( player5Line[4] ));player6X.add(Double.parseDouble ( player6Line[3] ));player6Y.add(Double.parseDouble ( player6Line[4] ));player7X.add(Double.parseDouble ( player7Line[3] ));  player7Y.add(Double.parseDouble ( player7Line[4] )); player8X.add(Double.parseDouble ( player8Line[3] )); player8Y.add(Double.parseDouble ( player8Line[4] )); player9X.add(Double.parseDouble ( player9Line[3] )); player9Y.add(Double.parseDouble ( player9Line[4] )); player10X.add(Double.parseDouble ( player10Line[3] )); player10Y.add(Double.parseDouble ( player10Line[4] ));
    homeTeam = player1Line[1];
    awayTeam = player10Line[1];
    //Information about the selected player
  if (selectedPlayer == 1){
     selectedPlayerID = player1Line[2];
  }
  if (selectedPlayer == 2){
     selectedPlayerID = player2Line[2];
  }
  if (selectedPlayer == 3){
     selectedPlayerID = player3Line[2];
  }
  if (selectedPlayer == 4){
     selectedPlayerID = player4Line[2];
  }
  if (selectedPlayer == 5){
     selectedPlayerID = player5Line[2];
  }
  if (selectedPlayer == 6){
     selectedPlayerID = player6Line[2];
  }
  if (selectedPlayer == 7){
     selectedPlayerID = player7Line[2];
  }
  if (selectedPlayer == 8){
     selectedPlayerID = player8Line[2];
  }
  if (selectedPlayer == 9){
     selectedPlayerID = player9Line[2];
  }
  if (selectedPlayer == 10){
     selectedPlayerID = player10Line[2];
  }
   //Get distance from selected player
    if (selectedPlayer == 1 && player1Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player1Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player1Line[4] )))));
  }
  if (selectedPlayer == 2 && player2Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player2Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player2Line[4] )))));
  }
  if (selectedPlayer == 3 && player3Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player3Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player3Line[4] )))));
  }
  if (selectedPlayer == 4 && player4Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player4Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player4Line[4] )))));
  }
  if (selectedPlayer == 5 && player5Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player5Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player5Line[4] )))));
  }
  if (selectedPlayer == 6 && player6Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player6Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player6Line[4] )))));
  }
  if (selectedPlayer == 7 && player7Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player7Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player7Line[4] )))));
  }
  if (selectedPlayer == 8 && player8Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player8Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player8Line[4] )))));
  }
  if (selectedPlayer == 9 && player9Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player9Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player9Line[4] )))));
  }
  if (selectedPlayer == 10 && player10Line[2].equals(selectedPlayerID)){
       distanceFromBallSelected.add((double)sqrt((float)sq((float)(Double.parseDouble( ballLine[3] )-Double.parseDouble ( player10Line[3] )))+sq((float)(Double.parseDouble( ballLine[4] )-Double.parseDouble ( player10Line[4] )))));
  }
  
   
  }
  //Find team IDs
  for (int i = 0; i<teamids.length;i++)
  {
    if (homeTeam.equals(teamids[i]))
      homeTeamIterator = i;
    if (awayTeam.equals(teamids[i]))
      awayTeamIterator = i;
  }
  
   //Find the selected player's name
  String playerNameLines[] = loadStrings("players.csv");
  if (selectedPlayer != -1)
  {
    for (int i = 0; i <playerNameLines.length;i++){
      String[] theLine = playerNameLines[i].split(",");
      if (theLine[0].equals(selectedPlayerID)){
        selectedPlayerFirstName = theLine[1];
        selectedPlayerLastName = theLine[2];
        selectedPlayerJerseyNum = Integer.parseInt( theLine[3] );
      }
    }
  }
     
  awayTeamImage = loadImage("data2/"+teamids[awayTeamIterator]+".jpg");
  homeTeamImage = loadImage("data2/"+teamids[homeTeamIterator]+".jpg");
  if (selectedPlayer != -1)
  selectedPlayerImage = loadImage("http://stats.nba.com/media/players/230x185/"+selectedPlayerID+".png","png");
 
 for (int i = 0; i<totalDistanceTraveled.length;i++){
   totalDistanceTraveled[i]=0;
 }
 for(int i = 0;i<ballX.size()-1;i++){
    double distanceTraveled1 = (player1X.get(i)-player1X.get(i+1))*(player1X.get(i)-player1X.get(i+1))+(player1Y.get(i)-player1Y.get(i+1))*(player1Y.get(i)-player1Y.get(i+1));
    totalDistanceTraveled[0] = totalDistanceTraveled[0]+distanceTraveled1;
     double distanceTraveled2 = (player2X.get(i)-player2X.get(i+1))*(player2X.get(i)-player2X.get(i+1))+(player2Y.get(i)-player2Y.get(i+1))*(player2Y.get(i)-player2Y.get(i+1));
    totalDistanceTraveled[1] = totalDistanceTraveled[1]+distanceTraveled2;
     double distanceTraveled3 = (player3X.get(i)-player3X.get(i+1))*(player3X.get(i)-player3X.get(i+1))+(player3Y.get(i)-player3Y.get(i+1))*(player3Y.get(i)-player3Y.get(i+1));
    totalDistanceTraveled[2] = totalDistanceTraveled[2]+distanceTraveled3;
     double distanceTraveled4 = (player4X.get(i)-player4X.get(i+1))*(player4X.get(i)-player4X.get(i+1))+(player4Y.get(i)-player4Y.get(i+1))*(player4Y.get(i)-player4Y.get(i+1));
    totalDistanceTraveled[3] = totalDistanceTraveled[3]+distanceTraveled4;
     double distanceTraveled5 = (player5X.get(i)-player5X.get(i+1))*(player5X.get(i)-player5X.get(i+1))+(player5Y.get(i)-player5Y.get(i+1))*(player5Y.get(i)-player5Y.get(i+1));
    totalDistanceTraveled[4] = totalDistanceTraveled[4]+distanceTraveled5;
     double distanceTraveled6 = (player6X.get(i)-player6X.get(i+1))*(player6X.get(i)-player6X.get(i+1))+(player6Y.get(i)-player6Y.get(i+1))*(player6Y.get(i)-player6Y.get(i+1));
    totalDistanceTraveled[5] = totalDistanceTraveled[5]+distanceTraveled6;
     double distanceTraveled7 = (player7X.get(i)-player7X.get(i+1))*(player7X.get(i)-player7X.get(i+1))+(player7Y.get(i)-player7Y.get(i+1))*(player7Y.get(i)-player7Y.get(i+1));
    totalDistanceTraveled[6] = totalDistanceTraveled[6]+distanceTraveled7;
     double distanceTraveled8 = (player8X.get(i)-player8X.get(i+1))*(player8X.get(i)-player8X.get(i+1))+(player8Y.get(i)-player8Y.get(i+1))*(player8Y.get(i)-player8Y.get(i+1));
    totalDistanceTraveled[7] = totalDistanceTraveled[7]+distanceTraveled8;
     double distanceTraveled9 = (player9X.get(i)-player9X.get(i+1))*(player9X.get(i)-player9X.get(i+1))+(player9Y.get(i)-player9Y.get(i+1))*(player9Y.get(i)-player9Y.get(i+1));
    totalDistanceTraveled[8] = totalDistanceTraveled[8]+distanceTraveled9;
     double distanceTraveled10 = (player10X.get(i)-player10X.get(i+1))*(player10X.get(i)-player10X.get(i+1))+(player10Y.get(i)-player10Y.get(i+1))*(player10Y.get(i)-player10Y.get(i+1));
    totalDistanceTraveled[9] = totalDistanceTraveled[9]+distanceTraveled10;
  }
   maxDistanceTraveled = 0;
  for (int i = 0; i<10;i++){
    if (maxDistanceTraveled<totalDistanceTraveled[i])
      maxDistanceTraveled = totalDistanceTraveled[i];
  }
}

//Draw the player at coords x,y and corresponding team
void drawPlayer(double x, double y, int team){
  pushMatrix();
  translate((float)x,(float)y);
  if(team == 1)
  fill(0,50,200);
  else
  fill(0,200,50);  
  ellipse(0,0,20,20);
  popMatrix();
}

void drawTargetedPlayer(double x, double y, int team){
  pushMatrix();
  translate((float)x,(float)y);
  fill(255,0,0);
  ellipse(0,0,20,20);
  popMatrix();
}
//Key pressing detector
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && gamesIterator>0) {
      gamesIterator--;
      time = 0;
      eventIterator = 0;
      selectedPlayer = -1;
      prevScore = "\"0 - 0\"";
      loadDataLines();
    }
    
    if (keyCode == DOWN&&gamesIterator<games.length-1) {
      gamesIterator++;
      time = 0;
      eventIterator = 0;
      selectedPlayer = -1;
      prevScore = "\"0 - 0\"";
      loadDataLines();
    } 
    
    if (keyCode == LEFT && eventIterator>0){
      eventIterator--;
      time = 0;
      loadDataLines();
    }
    if (keyCode == RIGHT && eventIterator<numberOfEvents-1){
      eventIterator++;
      time = 0;
      loadDataLines();
    }
    
  } 
   if (key == 'p' || key == 'P') {
      animate = true;
    }
    if (key == 's' || key == 'S'){
      animate = false;
    }
    if (key == 'r' || key == 'R'){
      time = 0;
    }
    if (key == 'g' || key == 'G'){
      typeGame = true;
    }
    if (key == 'e' || key == 'E'){
      typeEvent = true;
    }
    if (key == '1' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '1';
    }
    if (key == '2' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '2';
    }
    if (key == '3' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '3';
    }
    if (key == '4' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '4';
    }
    if (key == '5' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '5';
    }
    if (key == '6' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '6';
    }
    if (key == '7' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '7';
    }
    if (key == '8' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '8';
    }
    if (key == '9' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '9';
    }
    if (key == '0' && (typeGame == true || typeEvent == true)){
      gameString = gameString + '0';
    }
    if (keyCode == ENTER && typeGame == true){
      if(gameString.length()!=0){
      int number = Integer.parseInt(gameString);
      if (number>=0 && number<=80)
      {
        gamesIterator = number;
        time = 0;
        eventIterator = 0;
        selectedPlayer = -1;
        loadDataLines();
      }
      }
      gameString = "";
      typeGame = false;
      
    }
    else if (keyCode == ENTER && typeEvent == true){
      if(gameString.length()!=0){
      int number = Integer.parseInt(gameString);
      if (number>=0 && number<=numberOfEvents)
      {
        eventIterator = number;
        time = 0;
        selectedPlayer = -1;
        loadDataLines();
      }
      }
      gameString = "";
      typeEvent = false;
      
    }
    
}

//Draw the ball at x, y coords with height 
void drawBall(double x, double y, double localBallHeight){

  pushMatrix();
  translate((float)x,(float)y);
  fill(200,200,0);
  ellipse(0,0,(float)localBallHeight,(float)localBallHeight);
  popMatrix();
}

//Update the slider when mouse pressed, also update time
void mousePressed(){
  if(mouseX>sliderLeftBoundary && mouseX<sliderRightBoundary && mouseY>sliderTopBoundary && mouseY<sliderBottomBoundary)
  {
     sliderLeftX = mouseX-15;
     time = (int)((mouseX-630)/(sliderRightBoundary-sliderLeftBoundary)*ballX.size());
  }
  if(mouseX>100 && mouseX<885 && mouseY>100 && mouseY<567)
  {
    findClosestPlayer(mouseX,mouseY);
    loadDataLines();
  }
}

void findClosestPlayer(int xPosition, int yPosition){
  Double playerXPositions[] = new Double [10];
  Double playerYPositions[] = new Double [10];
  playerXPositions[0] = player1X.get(time)/100*830+100;playerXPositions[1] = player2X.get(time)/100*830+100;playerXPositions[2] = player3X.get(time)/100*830+100;playerXPositions[3] = player4X.get(time)/100*830+100;playerXPositions[4] = player5X.get(time)/100*830+100;playerXPositions[5] = player6X.get(time)/100*830+100;playerXPositions[6] = player7X.get(time)/100*830+100;playerXPositions[7] = player8X.get(time)/100*830+100;playerXPositions[8] = player9X.get(time)/100*830+100;playerXPositions[9] = player10X.get(time)/100*830+100;
  playerYPositions[0] = player1Y.get(time)/50*467+100;playerYPositions[1] = player2Y.get(time)/50*467+100;playerYPositions[2] = player3Y.get(time)/50*467+100;playerYPositions[3] = player4Y.get(time)/50*467+100;playerYPositions[4] = player5Y.get(time)/50*467+100;playerYPositions[5] = player6Y.get(time)/50*467+100;playerYPositions[6] = player7Y.get(time)/50*467+100; playerYPositions[7] = player8Y.get(time)/50*467+100;playerYPositions[8] = player9Y.get(time)/50*467+100;playerYPositions[9] = player10Y.get(time)/50*467+100;
  
  double minDistance = 1000000;
  int closestPlayer = 0;
  for (int j = 0; j<10;j++){
    double distanceFromMouse = (playerXPositions[j]-xPosition)*(playerXPositions[j]-xPosition)+(playerYPositions[j]-yPosition)*(playerYPositions[j]-yPosition);
    if (minDistance>distanceFromMouse)
    {
        minDistance = distanceFromMouse;
        closestPlayer = j;
    }
  }
  closestPlayer++;
  selectedPlayer = closestPlayer;
}

//Draw the black slider
void drawSlider(){
  pushMatrix();
  fill(0);
  rect(sliderLeftX,sliderTopY,30,50);
  popMatrix();
}

//Draw the grey slider background
void drawSliderBackground(){
  pushMatrix();
  translate(615,585);
  fill(150);
  rect(0,0,230,50);
  popMatrix();
}


//Draw the versus text
void drawVersus(){
  pushMatrix();
  translate(450,60);
  textSize(32);
  fill(50);
  text("versus", 0, 0);
  if (!score.equals("null"))
    prevScore = score;
  text(prevScore, 0, -30);
  popMatrix();
}

//Draw the team names
void drawTeamNames(){
  pushMatrix();
  translate(300,10);
  textSize(24);
  fill(0,200,50);  
  text(teamNames[awayTeamIterator],0,0,150,200);
  fill(0,50,200);
  text(teamNames[homeTeamIterator],300,0,150,200);
  popMatrix();
}

void drawTeamIcons(){
  pushMatrix();
  translate (150,0);
  image(awayTeamImage,0,0,100,100);
  image(homeTeamImage,600,0,100,100);
  popMatrix();
}

void drawEventNumber(){
  pushMatrix();
  textSize(20);
  fill(55);
  text("Event#: " + eventIterator,0,20);
  fill(55);
  text("Game#: " + gamesIterator,0,40);
  popMatrix();
}

void drawSelectedPlayer(){
  fill(255,255,255);
  if (selectedPlayer == 1)
      drawTargetedPlayer(player1X.get(time)/100*830+100,player1Y.get(time)/50*467+100,1);
  if (selectedPlayer == 2)
      drawTargetedPlayer(player2X.get(time)/100*830+100,player2Y.get(time)/50*467+100,1);
  if (selectedPlayer == 3)
      drawTargetedPlayer(player3X.get(time)/100*830+100,player3Y.get(time)/50*467+100,1);
  if (selectedPlayer == 4)
      drawTargetedPlayer(player4X.get(time)/100*830+100,player4Y.get(time)/50*467+100,1);
  if (selectedPlayer == 5)
      drawTargetedPlayer(player5X.get(time)/100*830+100,player5Y.get(time)/50*467+100,1);
  if (selectedPlayer == 6)
      drawTargetedPlayer(player6X.get(time)/100*830+100,player6Y.get(time)/50*467+100,1);
  if (selectedPlayer == 7)
      drawTargetedPlayer(player7X.get(time)/100*830+100,player7Y.get(time)/50*467+100,1);
  if (selectedPlayer == 8)
      drawTargetedPlayer(player8X.get(time)/100*830+100,player8Y.get(time)/50*467+100,1);
  if (selectedPlayer == 9)
      drawTargetedPlayer(player9X.get(time)/100*830+100,player9Y.get(time)/50*467+100,1);
  if (selectedPlayer == 10){
      drawTargetedPlayer(player10X.get(time)/100*830+100,player10Y.get(time)/50*467+100,1);
  }
}

void drawSelectedPlayerPicture(){
  pushMatrix();
  translate(100,700);
  strokeWeight(2);
  stroke(255,0,0);
  fill(255);
  rect(0,0,selectedPlayerImage.width,selectedPlayerImage.height-5);
  image(selectedPlayerImage,0,0,230,180);
  fill(50);
  stroke(50);
  popMatrix();
}

void drawSelectedPlayerName(){
  pushMatrix();
  translate(150,900);
  textSize(20);
  fill(55);
  text(selectedPlayerFirstName +" "+ selectedPlayerLastName,0,0);
  text("Jersey number: "+ selectedPlayerJerseyNum,-20,20);
  popMatrix();
}

//We will draw a graph of time vs distance to ball.
void drawGraph(int timeUpperBound,int distanceUpperBound){
  pushMatrix();
  translate(600,655);
  strokeWeight(2);
  //Draw the x and y axis
  line(0,0,0,250);
  line(0,250,250,250);
  //Draw the indentations on the axis
  line(0,0,6,0);line(0,50,6,50);line(0,100,6,100);line(0,150,6,150);line(0,200,6,200);
  line(50,250,50,244);line(100,250,100,244);line(150,250,150,244);line(200,250,200,244);line(250,250,250,244);
  //Draw the labels for each indent
  textSize(16);
  text(timeUpperBound,235,265);
  text(timeUpperBound/5*4,185,265);
  text(timeUpperBound/5*3,135,265);
  text(timeUpperBound/5*2,85,265);
  text(timeUpperBound/5*1,35,265);
  text(0,0,265);
  text(distanceUpperBound,-35,5);
  text(distanceUpperBound/5*4,-35,55);
  text(distanceUpperBound/5*3,-35,105);
  text(distanceUpperBound/5*2,-35,155);
  text(distanceUpperBound/5*1,-35,205);
  text(0,-15,255);
  //Draw the line of data
  stroke(255,0,0);
  for (int i = 0; i<distanceFromBallSelected.size()-1;i++){
    line((float)((double)i/(double)(timeUpperBound)*(double)250),(float)(250-3*distanceFromBallSelected.get(i)),(float)((double)(i+1)/(double)(timeUpperBound)*(double)250),(float)(250-3*distanceFromBallSelected.get(i+1)));
  }
  stroke(0);
  //Draw the triangle
  fill(0,0,250);
  triangle((float)((double)time/(double)(timeUpperBound)*(double)250),(float)(250-3*distanceFromBallSelected.get(time))-4,(float)((double)time/(double)(timeUpperBound)*(double)250)-5,(float)(250-3*distanceFromBallSelected.get(time))-15,(float)((double)time/(double)(timeUpperBound)*(double)250)+5,(float)(250-3*distanceFromBallSelected.get(time))-15);
  fill(0);
  //Draw the labels for the axes
  textSize(18);
  text("Moment", 90,300);
  text("Distance to Ball", -125,100,80,200);
  popMatrix();
}

void drawGameType(){
    fill(50);
    textSize(20);
    if (typeGame == true)
    {
      text("Type game#",0,70);
      text("0 to 80",0,90);
    }
    if (typeEvent == true)
    {
      text("Type event#",0,70);
      text("0 to " + (numberOfEvents-1),0,90);
    }
    text(gameString,0,110);
}

void drawTenPlayerGraph(){
  pushMatrix();
  translate(100,650);
  line(0,0,400,0);
  textSize(16);
  //Draw the player labels for each indent
  for(int i = 0; i<10;i++){
    text((i+1),400/10*i+10,16);
  }
  textSize(20);
  text("Overall Distance Traveled",100,40);
 
 for (int i = 0; i<10;i++){
   if (i<=4)
     fill(0,50,200);
   else
     fill(0,200,50);
   if (selectedPlayer == i+1)
     fill(255,0,0);
   rect((float)(400/10*i),(float)(totalDistanceTraveled[i]/maxDistanceTraveled*(-60)),40,(float)(totalDistanceTraveled[i]/maxDistanceTraveled*(60)));
 }
  
  popMatrix();
}

void draw() {

  background(240);
  //Dimensions of court are 785 width, 467 height;
  image(court,100,100);
  fill(55);
  //text(frameRate, 100, 50);
  drawSliderBackground();
  drawSlider();
  drawVersus();
  drawTeamIcons();
  drawTeamNames();
  drawEventNumber();
  drawGameType();
  drawTenPlayerGraph();
  if(selectedPlayer!=-1){
    drawSelectedPlayerPicture();
    drawSelectedPlayerName();
    drawGraph(ballX.size(),300);
  }
  //Draw the balls and players
  drawBall(ballX.get(time)/100*830+100,ballY.get(time)/50*467+100,ballH.get(time)*10);
  drawPlayer(player1X.get(time)/100*830+100,player1Y.get(time)/50*467+100,1);
  drawPlayer(player2X.get(time)/100*830+100,player2Y.get(time)/50*467+100,1);
  drawPlayer(player3X.get(time)/100*830+100,player3Y.get(time)/50*467+100,1);
  drawPlayer(player4X.get(time)/100*830+100,player4Y.get(time)/50*467+100,1);
  drawPlayer(player5X.get(time)/100*830+100,player5Y.get(time)/50*467+100,1);
  drawPlayer(player6X.get(time)/100*830+100,player6Y.get(time)/50*467+100,0);
  drawPlayer(player7X.get(time)/100*830+100,player7Y.get(time)/50*467+100,0);
  drawPlayer(player8X.get(time)/100*830+100,player8Y.get(time)/50*467+100,0);
  drawPlayer(player9X.get(time)/100*830+100,player9Y.get(time)/50*467+100,0);
  drawPlayer(player10X.get(time)/100*830+100,player10Y.get(time)/50*467+100,0);
 
  drawSelectedPlayer();
   // Animate if P is pressed, stop if S is pressed
//  if (keyPressed) {
   
//  }
  if (animate)
    time++;
  if (time == ballX.size())
    time = 0;
}