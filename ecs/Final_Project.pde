// Elena Sandulli | 2048 Final Project | 4/20/23

PImage photo;
int [][] board = new int [4][4];
int padding= 20, blockSize= 100, len = padding*(board.length+1)+blockSize*board.length;
int score = 0, MovePossible =0;
int right,down;
boolean C_pressed = false;


void setup(){
  size(600,900); 
  restart();
  photo = loadImage("beachsunset.jpeg");
}

void restart(){
  board = new int[4][4];
  score = 0;
  MovePossible = 1;
  generateBlock();                  
  generateBlock();                  
  C_pressed = false;
  //board[0][0]=1024;               
  //board[0][3]=1024;
  
};


void draw(){
  image(photo,0,0);
  for(int j = 0; j < board.length; j++){
    for(int i = 0; i < board.length; i++){
      float x = padding+(padding+blockSize)*i;
      float y = padding+(padding+blockSize)*j;
      rectangle(x,y, blockSize, blockSize, 5, color(150, 200, 255));
     
      if(board[j][i] > 0){
        changeBlockColor(j,i,x,y,blockSize, blockSize, 2);
        changeBlockText(CENTER, ""+board[j][i], x , y+22, blockSize, blockSize, 36);
      }
    }
  }
  
  updateScore(score);
  textGameOver(MovePossible);
  textYouWon(CheckYouWon());
  text("Press r to restart",0,600,400,150);
  
  
};

void rectangle (float rec_x, float rec_y, float rec_width, float rec_height, float radius, color clr){
  fill(clr);
  rect(rec_x,rec_y,rec_width,rec_height,radius);
  
};

void changeBlockColor (int count_x,int count_y,float x_rect, float y_rect, float width_rect, float height_rect,float radius_rect){
    float powerOf2 = log(board[count_x][count_y])/log(2);
    rectangle (x_rect,y_rect,width_rect,height_rect,radius_rect, color(200-powerOf2*200/11, powerOf2*300/11, 0));
};

void changeBlockText(int align, String text_string,float text_x, float text_y, float text_width, float text_height, float text_Size){
  fill(color(0));
  textAlign(align);
  textSize(text_Size);
  text(text_string, text_x,text_y,text_width,text_height);
};


void updateScore (int score){
  fill(color(0));
  text("Score: "+score,30,700-150,250,150);
  textSize(40);
};

void CheckRestartGame(){                  
  if(keyPressed){                              
         if (key == 'r' || key == 'R')
            restart();
      }
}


void textGameOver(int moveposs){          
if(moveposs == 0){
      fill(color(0));
      text("Gameover! Click to restart!",width/2,height/3,30);
      textSize(40);
    
      if(mousePressed)
      restart();
      CheckRestartGame();
      
    }
}


void textYouWon(boolean wonistrue){  
  if(wonistrue == true && C_pressed == false) {
      fill(color(0));
      text("YOU have WON!!!",width/2,height/3,30);
      text("Press C to continue!",width/2,height/6,30);
      textSize(36);
     
  }
}

boolean CheckYouWon(){  
  boolean Won = false;
  for(int j = 0; j < board.length; j++){    
    for(int i = 0; i < board.length; i++){
      if(board[j][i] >= 2048)
        Won = true;
    }
  }
    if(keyPressed){                              
      if (key == 'c' || key == 'C')
         C_pressed = true;
      }
  return Won;
}

void keyPressed() {
  if(MovePossible != 0){
    switch (keyCode) {
      case 37://LEFT
          right = -1;
          down = 0;
      break;
      case 38://UP
          down =-1;
          right =0;
        break; 
      case 39://RIGHT
           right = 1;
           down = 0;
        break; 
      case 40://DOWN
           down = 1;
           right = 0;
        break; 
      default:
            down = 0;
           right = 0;
        break;  
      }
    
    CheckRestartGame();      
    movement();              
    CheckYouWon();           
    
  }
    if(NoGameOver()){        
        MovePossible = 1;
    }else
        MovePossible = 0;
}


void generateBlock(){                                         
  ArrayList<Integer> column = new ArrayList<Integer>();      
  ArrayList<Integer> row = new ArrayList<Integer>();        
  
  for(int j = 0; j < board.length; j++){    
    for(int i = 0; i < board.length; i++){
      if(board[j][i]== 0){                                  
        column.add(i);
        row.add(j);
      }  
    }
  }
      int randnum = (int)random(0, row.size());
      int x= column.get(randnum);
      int y= row.get(randnum);
    
      if(random(0,2) < 1)                                  
        board[y][x] =2;
      else
        board[y][x] =4; 
};

 
int[][] play(int UpDown, int RightLeft, boolean scoreupdate){
  int[][] backup = new int[4][4];                                          
  
  for(int j = 0; j < board.length; j++){    
    for(int i = 0; i < board.length; i++){
      backup[j][i] = board[j][i];
    }
  }
  
  boolean moved =false;
  
  if(UpDown !=0 || RightLeft !=0){
    int step_direction = RightLeft !=0 ? RightLeft : UpDown;        

    
    
    
    for(int nth_row = 0;  nth_row < board.length; nth_row++)
      for(int nth_column = (step_direction > 0 ? board.length-2 : 1);  nth_column != (step_direction > 0 ? -1: board.length); nth_column -= step_direction){        //nth-cloumn (n=0,1,2,3)
          int y = RightLeft != 0 ? nth_row : nth_column;
          int x = RightLeft != 0 ? nth_column : nth_row;
          int dy = y;                                                       
          int dx = x;                                                   
          
          
      
          if(backup[y][x]==0) continue;
          
            
            for(int i = (RightLeft != 0 ? x : y)+step_direction; i != (step_direction > 0 ? board.length : -1); i+=step_direction){
              int a = RightLeft != 0 ? y : i;                          
              int b = RightLeft != 0 ? i : x;
              
      
              if(backup[a][b] != 0 && backup[a][b] != board[y][x]) break;
            
              
              if(RightLeft != 0) 
                  dx = i;
              else
                  dy = i;    
            }
            
      
            if((RightLeft != 0 && dx == x) || (UpDown != 0 && dy == y)) continue;
            
            
            
            else if(backup[dy][dx] == board[y][x]){ 
              backup[dy][dx] *= 2;                                      
              if(scoreupdate) 
                score += backup[dy][dx];
                updateScore(score);
                moved =true;
               
            }
            
            
            else if((RightLeft != 0 && dx != x ) || (UpDown !=0 && dy != y)){ 
              backup[dy][dx] = backup[y][x];
              moved =true;
            }
            
            
            if(moved)                                
              backup[y][x]= 0;                      
            
          }
      }
      return moved ? backup : null;
  }
  
  

boolean NoGameOver(){
  int [] Right = {1,-1,0,0}, Down = {0,0,1,-1};          
  boolean gameover = false;
  
    for(int i=0; i < 4; i++){
      if(play(Down[i],Right[i],false) != null)            
        gameover = true;
    }
    return gameover;
};


boolean movement(){
    int[][] newboard  = play(down,right,true);
    if(newboard != null){
      board = newboard;
      generateBlock();
        return true;
    }else
       return false;
  }   
