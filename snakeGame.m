% Script File - Snake Game
%
% Names: William Hankins & Randy Loberger
% Course: EGR115, Section 3, Fall 2020
% Final Project
%
% Description:
%
% Variable Definitions:
%
%

% Initilize variables.
score = 0;


% Generate first piece of food.
[food_x, food_y] = generatefood();

while %Snake has not hit wall or itself
    
    % Check if snake has ate food.
    snake_ate = checkfood(snakehead_x, snakehead_y, food_x, food_y);
    if snake_ate
        [food_x, food_y] = generatefood();
        score = score + 1;
    end
end