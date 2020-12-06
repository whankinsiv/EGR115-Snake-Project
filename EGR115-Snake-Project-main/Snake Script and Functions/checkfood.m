function result = checkfood(snakehead_x, snakehead_y, food_x, food_y)
%checkfood - Checks if the snake head and food are in the same location.
%Function checkfood recieves 4 input arguments, snakehead_x, snakehead_y,
%food_x, and food_y. The function checks if the snake head and food are in
%the same location and if so returns a 1 for true. Otherwise, the function
%returns a 0 for false.
%
%Created by: William Hankins
%
%Syntax: result = checkfood(snakehead_x, snakehead_y, food_x, food_y)

% Check if snakehead and food are in the same location.
if (snakehead_x == food_x) && (snakehead_y == food_y)
    result = 1; %True
else
    result = 0; % False
end