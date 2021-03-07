import g4p_controls.*;
int KEY_SHIFT=16;
int MODE=0;
int BORDER_X=2;
int BORDER_Y=2;
int VX = 2;
int VY = 2;
int HEAD_Y = 20;
int HEAD_X = 20;
int OLX = 64;
int OLY = 32;
int OCX = 32;
int OCY = 16;
int OTS = 16;
int LX = OLX;
int LY = OLY;
int CX = OCX;
int CY = OCY;
int TS = OTS;
GButton btnLeft;
GButton btnRight;
GButton btnUp;
GButton btnDown;
GButton btnMode;
IntList discoveredPrims;
IntList discoveredBorders;

void setup() {
   discoveredPrims = new IntList();
   discoveredBorders = new IntList();
   int WIN_WIDTH = 1900;
   int WIN_HEIGHT = 600;
   size(1900, 600);
   PApplet sketchPApplet=this;
   btnLeft = new GButton(sketchPApplet,HEAD_X*1.0,0.0,100.0,HEAD_Y*1.0);
   btnRight = new GButton(sketchPApplet,WIN_WIDTH*1.0-100.0,0.0,100.0,HEAD_Y*1.0);
   btnUp = new GButton(sketchPApplet,0.0,HEAD_Y*1.0,HEAD_X*1.0,100.0);
   btnDown = new GButton(sketchPApplet,0.0,WIN_HEIGHT-170.0,HEAD_X*1.0,100.0);
   btnMode = new GButton(sketchPApplet,WIN_WIDTH*1.0-100,WIN_HEIGHT-50.0,100.0,50.0,"MODE 0");
}
void handleButtonEvents(GButton button, GEvent event) {
   if((VX-5>0)&&(button == btnLeft && event == GEvent.CLICKED)){
       VX -= 5;
   }
   if(button == btnRight && event == GEvent.CLICKED){
       VX += 5;
   }
   if((VY-5>0)&&(button == btnUp && event == GEvent.CLICKED)){
       VY -= 5;
   }
   if(button == btnDown && event == GEvent.CLICKED){
       VY += 5;
   }
   if(button == btnMode){
     MODE = 1 - MODE;
   }
}
float Factor = 1.0;
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0){
    Factor *= 2;
  }
  if(e < 0){
    Factor /= 2;
  }
  LX = floor(Factor * OLX);
  LY = floor(Factor * OLY);
  CX = floor(OCX / Factor );
  CY = floor(OCY / Factor);
  TS = floor(Factor * OTS);
  println("Factor:"+Factor+" LX:"+LX+" LY:"+LY+" CX:"+CX+" CY:"+CY);
}
/*void mouseClicked(){
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
}*/
void draw_mode0(){
  draw_mode0(false);
}
void draw_mode0(boolean sq){
    int mx = floor((mouseX-HEAD_X)/LX)+VX;
    int my = floor((mouseY-HEAD_Y)/LY)+VY;
    int tmx = mx;
    int tmx2 = mx;
    int tmx3 = mx;
    int tmx4 = mx;
    float tmx5 = mx;
    float tmx6 = mx;
    float tmx7 = mx;
    int tmy = my;
    boolean tmx7neg = false;
    if((mouseX>HEAD_X)&&(mouseY>HEAD_Y)&&(mouseY<HEAD_Y+CY*LY)){
      while(tmy>0){
        //DIAGONAL
        fill(255, 255, 255);
        int x1 = HEAD_X+(tmx-VX)*LX;
        int y1 = HEAD_Y+(tmy-VY)*LY;
        int x2 = HEAD_X+(tmx-VX+1)*LX;
        int y2 = HEAD_Y+(tmy-VY+1)*LY;
        rect(x1,y1,x2-x1,y2-y1);

        fill(200, 200, 200);
        x1 = HEAD_X+(tmx2-VX)*LX;
        y1 = HEAD_Y+(tmy-VY)*LY;
        x2 = HEAD_X+(tmx2-VX+1)*LX;
        y2 = HEAD_Y+(tmy-VY+1)*LY;
        rect(x1,y1,x2-x1,y2-y1);
        fill(150, 150, 150);
        x1 = HEAD_X+(tmx3-VX)*LX;
        y1 = HEAD_Y+(tmy-VY)*LY;
        x2 = HEAD_X+(tmx3-VX+1)*LX;
        y2 = HEAD_Y+(tmy-VY+1)*LY;
        rect(x1,y1,x2-x1,y2-y1);
        fill(100, 100, 100);
        x1 = HEAD_X+(tmx4-VX)*LX;
        y1 = HEAD_Y+(tmy-VY)*LY;
        x2 = HEAD_X+(tmx4-VX+1)*LX;
        y2 = HEAD_Y+(tmy-VY+1)*LY;
        rect(x1,y1,x2-x1,y2-y1);
        if((tmx5 % 1) == 0){
          fill(150, 150, 150);
          x1 = HEAD_X+int((tmx5-VX)*LX);
          y1 = HEAD_Y+(tmy-VY)*LY;
          x2 = HEAD_X+int((tmx5-VX+1)*LX);
          y2 = HEAD_Y+(tmy-VY+1)*LY;
          rect(x1,y1,x2-x1,y2-y1);
        }
        if((tmx6 % 1) == 0){
          fill(100, 100, 100);
          x1 = HEAD_X+int((tmx6-VX)*LX);
          y1 = HEAD_Y+(tmy-VY)*LY;
          x2 = HEAD_X+int((tmx6-VX+1)*LX);
          y2 = HEAD_Y+(tmy-VY+1)*LY;
          rect(x1,y1,x2-x1,y2-y1);
        }

        fill(0, 255, 0);
        x1 = HEAD_X+int(tmx7-VX)*LX;
        y1 = HEAD_Y+(tmy-VY)*LY;
        x2 = HEAD_X+int(tmx7-VX+1)*LX;
        y2 = HEAD_Y+(tmy-VY+1)*LY;
        rect(x1,y1,x2-x1,y2-y1);

        tmy -= 1;
        tmx += 1;
        tmx2 += 2;
        tmx3 += 3;
        tmx4 += 4;
        tmx5 += 0.5;
        tmx6 += 0.25;
        
        if(tmx7neg){
          tmx7 += 2;
        }else{
          tmx7 -= 2;
          if(tmx7 <= -1.0){
            tmx7 = - tmx7;
            tmx7neg = true;
          }
        }
 
      }
    }
    
    IntDict specialColor = new IntDict();
    if(keyPressed &&(keyCode==KEY_SHIFT)){
        if(my == mx){
          //print("#"+tmy+":"+tmx+"\n");
          for(int i=1;i<mx;i++){
            for(int j=1;j * i<CX-(mx-VX);j++){
              int nx = (mx + j*i);
              int ny = (my - i);
              if((nx % ny) == 0){
                break;
              }
              String skey = ""+nx+":"+ny;
              specialColor.set(skey,1);
              //print(skey+"\n");
            }
          }
        }else{
          print(mx + "!=" + my + "\n");
        }
      }else if((log(mx)/log(2)) % 1 == 0){
      if(mousePressed){
        int NS = floor(pow(2,floor(log(mx)/log(2))+1));
        for(my=VY;my<mx;my++){
          int N1 = (mx % my);
          int N2 = my - N1;
          tmx = mx;
          do{
            specialColor.set(""+(tmx + N2),1);
            tmx += my;
          }while(tmx+N2<NS);
        }
        
      } else {
        int N1 = (mx % my);
        int N2 = my - N1;
        int NS = floor(pow(2,floor(log(mx)/log(2))+1));
        tmx = mx;
        do{
          specialColor.set(""+(tmx + N2),1);
          //print(N1+","+N2+","+tmx+","+my+","+specialColor+"\n");
          tmx += my;
        }while(tmx+N2<NS);
      }
    }
    
    for(int i1=VX;i1<VX+CX;i1++){
      boolean prim = true;
      for(int i2=2;i2<i1;i2++){
        int N = (i1 % i2);
        if(N == 0){
          prim = false;
          break;
        }
      }
      if(prim){
        if(!discoveredPrims.hasValue(i1)){
          discoveredPrims.append(i1);
          int v = 1;
          if(discoveredBorders.size()>0){
            v = discoveredBorders.get(discoveredBorders.size()-1);
          }
          //discoveredBorders.append(v*(i1-1));
          discoveredBorders.append(v*i1);
        }
      }
      for(int i2=VY;i2<VY+CY;i2++){
        int N  = (i1 % i2);
        int N2 = i2 - N;
        if(N != 0){
          String k1 = ""+i1+":"+i2;
          String k2 = ""+i1;
          if(discoveredBorders.hasValue(i1)){
            fill(100, 0, 0);
          }
          else if(specialColor.hasKey(k1)||specialColor.hasKey(k2)){
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
        int x2 = HEAD_X+(i1-VX+1)*LX-BORDER_X;
        int y2 = HEAD_Y+(i2-VY+1)*LY-BORDER_Y;
        if(sq){
          if(i2 > sqrt(i1)){
            fill(0, 0, 0);
          }
        }
        rect(x1,y1,x2-x1,y2-y1);
        if(Factor > 0.25){
            fill(0, 255, 0);
            text(""+N,5+x1,y1,5+x2,y2);
            fill(150, 150, 150);
            text(""+N2,LX/2+5+x1,y1,LX/2+5+x2,y2);
        }
      }
    }
    
    
    if((my!=0)&&(my+1!=0)){
      textSize(16);
      fill(255, 255, 255);
      int N1 = (mx % my);
      int N2 = my - N1;
      text(N1 + "="+mx+"%"+my,HEAD_X,HEAD_Y+(OCY+1)*OLY);
      text(N2 + "="+my+"-("+mx+"%"+my+")",HEAD_X,HEAD_Y+(OCY+2)*OLY);
      
      int my2 = my + 1;
      int N21 = (mx % my2);
      //int Zt = floor((mx-2) / my);
      int Zt = 1;
      do{
        Zt += 1;
      }while((mx / Zt)>my);
      //int Z = Zt;
      int Z = Zt-1;
      if((N21+Z)%my == (mx % my)){
        text("=("+N21+"+"+Z+")"+"%"+my,HEAD_X+3*OLX,HEAD_Y+(OCY+1)*OLY);
        text("="+my+"-("+N21+"+"+Z+")"+"%"+my,HEAD_X+3*OLX,HEAD_Y+(OCY+2)*OLY);
      }
      text("mx:"+mx+",my:"+my,HEAD_X+10*OLX,HEAD_Y+(OCY+1)*OLY);
      text("((" + mx + "%" + my +")*2)%"+my+"="+((N1*2) % my),HEAD_X+13*OLX,HEAD_Y+(OCY+1)*OLY);
      if(keyPressed){
        text("key:"+keyCode ,HEAD_X+13*OLX,HEAD_Y+(OCY+2)*OLY);  
      }
    }
}
void draw_mode1(){
  draw_mode0(true);
}
void draw() {
  textSize(TS);
  background(0);

  if(MODE == 0){
    draw_mode0();    
  }else if(MODE == 1){
    draw_mode1();
  }
}
