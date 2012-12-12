class GameOver {
  
  
 void drawOver(){
   background(0);

   fill(255);
   textFont(gFont, 48);
   
   video.read();
    image(video, 50, 150, 320, 240);
    image(video1, 500, 150, 320, 240);
    image(video2, 250, 500, 320, 240);
    text("YOU LOST!",400,550);
       image (logoImage,width/3, 200);
   //button.display();
   
 }
}
