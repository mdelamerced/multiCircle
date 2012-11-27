class Start{
  
  void drawStart(){
   fill(0);
   rect (0,0, width, height);
   fill(255);
   textFont(gFont, 48);
   text("Click and Hold It", 200,200);
   button.display();
   text("Start Game", 275, 300);
   textFont(gFont, 20);
   text("Requires 4 players to start", 275,350);
   text("There are  "+myNetAddressList.list().size()+"  players ready.", 270, 375);
  }
  

}
