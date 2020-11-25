function [food_x, food_y] = generatefood()

% Generate random x and y cordinate for food location.
food_x = floor(1+ (21-1)*rand);
food_y = floor(1+ (21-1)*rand);