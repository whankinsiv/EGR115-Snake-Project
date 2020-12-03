function [food_row, food_col] = generatefood()

% Generate random x and y cordinate for food location.
food_row = floor(1+ (16-1)*rand);
food_col = floor(1+ (31-1)*rand);
