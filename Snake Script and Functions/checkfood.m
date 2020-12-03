function result = checkfood(snakehead_x, snakehead_y, food_x, food_y)

if (snakehead_x == food_x) && (snakehead_y == food_y)
    result = 1; %True
else
    result = 0; % False
end