function [food_row, food_col] = generatefood()
%generatefood - Generates an (row,column) location in a 15x30 matrix
%Function generatefood recieves no input arguments and returns a value for
%row and a value of column on a 15 row by 30 column matrix
%
%Created by: William Hankins
%
%Syntax: [food_row, food_col] = generatefood()  

% Generate random row and column values on a 15x30 matrix.
food_row = floor(1+ (16-1)*rand);
food_col = floor(1+ (31-1)*rand);
