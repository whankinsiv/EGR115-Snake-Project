function [y,x] = findsnakeend(map, row, column, direction)
%findsnakeend - Finds the tail in the snake game based on the head.
%Tracks down the end of the snake based on the coordinate location of the
%head of the snake.
%
%Created by: Randy Loberger
%
%Syntax: [y,x] = trackthesnake(map, row, column, direction)  


%setting all constants needed
first_dir = direction;
x = column;
y = row;
test = 0;
snake = ['                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '
         '                              '];
snake(y,x) = '=';


%testing if the final location has been found (loop)
while (test < 4)
    
%fail safe for if the location fails and x and y need to be reverted
    k = x;
    j = y;
    
%testing the initial location's opposite to see if the snake is where
%expected
    if direction == 'w'
        y = y + 1;    
    elseif direction == 'd'
        x = x - 1;
    elseif direction == 'a'
        x = x + 1;
    elseif direction == 's'
        y = y - 1;
    end
        
%checking if the location calculated was the snake or not    
    if (map(y,x) == '=') && (map(y,x) ~= snake(y,x))
        first_dir = direction;
        test = 0;
        snake(y,x) = '=';
        
%the if statement for if the location found is not the snake
    else
        x = k;
        y = j;
 
%direction set if the initial direction was w or up        
        if first_dir == 'w'
            test = test + 1;
            direction = 'd';
            if (first_dir == 'w') && (test == 2)
                direction = 'a';
                test = test + 1;
            elseif (first_dir == 'w') && (test == 3)
                test = 4;
            end
       end
  
%direction set if the initial direction was d or right         
       if first_dir == 'd'
           test = test + 1;
           direction = 'w';
           if (first_dir == 'd') && (test == 2)
               direction = 's';
           elseif (first_dir == 'd') && (test == 3)
               test = 4;
           end
       end
       
%direction set if the initial direction was s or down         
       if first_dir == 's'
           test = test + 1;
           direction = 'a';
           if (first_dir == 's') && (test == 2)
               direction = 'd';
           elseif (first_dir == 's') && (test == 3)
               test = 4;
           end
       end
            
%direction set if the initial direction was a or left         
       if first_dir == 'a'
           test = test + 1;
           direction = 'w';
           if (first_dir == 'a') && (test == 2)
               direction = 's';
           elseif (first_dir == 'a') && (test == 3)
               test = 4;
           end
       end
    end
end