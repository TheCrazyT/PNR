int VX = 2;
int VY = 2;
int HEAD_Y = 20;
int HEAD_X = 20;
int LX = 60;
int LY = 20;
int CX = 30;
int CY = 35;
void setup() {
   size(1600, 800);
   textSize(16);
}
void draw() {
  background(0);
  if(mousePressed){
    if((mouseY < HEAD_Y)&&(mouseX > 400)){
      VX += 5;
    }
    if(VX > 2){
      if((mouseY < HEAD_Y)&&(mouseX < 400)){
        VX -= 5;
      }
    }
    if((mouseX < HEAD_X)&&(mouseY > 400)){
      VY += 5;
    }
    if(VY > 2){
      if((mouseX < HEAD_X)&&(mouseY < 400)){
        VY -= 5;
      }
    }
  }
  
  int mx = floor((mouseX-HEAD_X)/LX)+VX;
  int my = floor((mouseY-HEAD_Y)/LY)+VY;
  IntDict specialColor = new IntDict();
  if((log(mx)/log(2)) % 1 == 0){
    if(mousePressed){
      int NS = floor(pow(2,floor(log(mx)/log(2))+1));
      for(my=VY;my<mx;my++){
        int N1 = (mx % my);
        int N2 = my - N1;
        int tmx = mx;
        do{
          specialColor.set(""+(tmx + N2),1);
          tmx += my;
        }while(tmx+N2<NS);
      }
    }else{
      int N1 = (mx % my);
      int N2 = my - N1;
      int NS = floor(pow(2,floor(log(mx)/log(2))+1));
      do{
        specialColor.set(""+(mx + N2),1);
        print(N1+","+N2+","+mx+","+my+","+specialColor+"\n");
        mx += my;
      }while(mx+N2<NS);
    }
  }
  
  for(int i1=VX;i1<VX+CX;i1++){
    boolean prim = true;
    for(int i2=2;i2<i1;i2++){
      int N = (i1 % i2);
      if(N == 0){
        prim = false;
      }
    }
    for(int i2=VY;i2<VY+CY;i2++){
      int N  = (i1 % i2);
      int N2 = i2 - N;
      if(N != 0){
        if(specialColor.hasKey(""+(i1))){
          //print("K2:" + K2+"\n");
          fill(0, 255, 255);
        }else{
          if((log(i1)/log(2)) % 1 == 0){
              fill(255, 255, 0);
          }else{
            if(prim){
              fill(0, 0, 100);
            }else{
              fill(0, 0, 255);
            }
          }
        }
      }else{
        fill(255, 0, 0);
      }
      int x1 = HEAD_X+(i1-VX)*LX;
      int y1 = HEAD_Y+(i2-VY)*LY;
      int x2 = HEAD_X+(i1-VX+1)*LX-2;
      int y2 = HEAD_Y+(i2-VY+1)*LY-2;
      rect(x1,y1,x2-x1,y2-y1);
      fill(0, 255, 0);
      text(""+N,5+x1,y1,5+x2,y2);
      fill(150, 150, 150);
      text(""+N2,LX/2+5+x1,y1,LX/2+5+x2,y2);
    }
  }
  int N1 = (mx % my);
  int N2 = my - N1;
  text(N1 + "="+mx+"%"+my,HEAD_X,HEAD_Y+(CY+1)*LY);
  text(N2 + "="+my+"-("+mx+"%"+my+")",HEAD_X,HEAD_Y+(CY+2)*LY);
}
