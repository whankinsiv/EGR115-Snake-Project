% Script File - Snake Game
%
% Name: William Hankins
% Course: EGR115, Section 3, Fall 2020
% Final Project
%
% Description:
%   Snake game created for Final Project for Embry Riddle EGR 115.
%   A figure window will appear that will display the map. Press any key to
%   begin the game. The objective of the game is collect as much food as
%   possible before hitting the walls, '#' or the snake itself, '='. Once a
%   piece of food is eaten, a new piece, denoted by 'X' will randomly
%   generate within the map. Controls for the game are 'W' for up, 'A' for 
%   left, 'S' for down, and 'D' for left. The user can exit the game by 
%   pressing 'Q'. We hope that you enjoy playing our game as much as we
%   enjoyed creating it. 
%
% Variable Definitions:
%   map = a 15x30 string matrix that serves as the playing field.
%   food_row = the row value generated from the generatefood function.
%   food_col = the column value generated from the generatefood function.
%   fig1 = The figure window on which the game will be displayed.
%   score = A string vector which includes the current game score.
%   scoreanno = The annotation that generates the score on figure window.
%   old_highscore = The old highscore given by the savescores function.
%   highscore_string = A string vector which includes the old highscore.
%   mapanno = The annotation that generates the map on the figure window.
%   hitobstacle = Checks if the snake has hit itself or the wall.
%   direction = The user input for what direction the snake will move.
%   head_row = The row value of the snake head.
%   head_col = The column value of the snake head.
%   realscore = The amount of food the snake has eaten times 10.
%   foodeaten = The amount of pieces of food the snake has eaten.
%   olddirection = The value for direction in the previous loop.
%   result = Checks if the snake has eaten the food yet.
%   newhighscore = Checks if there is a new highscore after the game.

% Seed random number generator.
rng('Shuffle')

% Create map.
map = ['##############################'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                 ==         #'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                            #'
       '#                            #'
       '##############################'];

% Generate first piece of food.
[food_row, food_col] = generatefood();
while ~(map(food_row, food_col) == ' ')
    % If the generated food is on a snake or hash location,
    % generate a new piece of food.
    [food_row, food_col] = generatefood();
end
map(food_row, food_col) = 'X';


% Setup figure window.
fig1 = figure('Name','Snake Game','NumberTitle','off','Color','k');
set(fig1, 'MenuBar', 'none', 'Position',  get(0,'ScreenSize'));

% Create title on figure window.
annotation('textbox', [.400 .9 .2 .05], 'String', 'Snake Game', ...
    'FontWeight', 'bold', 'BackgroundColor', 'k', 'HorizontalAlignment',...
    'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c');

% Create score box on figure window.
score = 'Score: 0';
scoreanno = annotation('textbox', [.400 .85 .2 .05], 'String', score,...
    'FontWeight', 'bold', 'BackgroundColor', 'k', 'HorizontalAlignment',...
    'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c');

% Create highscore box on figure window.
old_highscore = savescores();
highscore_string = ['High Score: ', int2str(old_highscore)];
annotation('textbox', [.4 .74 .2 .05], 'String', highscore_string, ...
    'BackgroundColor', 'y', 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', 'FitBoxToText', 'on', 'FontSize', 18);

% Create map.
mapanno = annotation('textbox', [.42 .20 .18 .55], 'String', map, ...
        'BackgroundColor', '#EDB120', 'FontSize',25, 'Margin', 0, ...
        'FitBoxToText', 'on', 'FontName', 'FixedWidth', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

% Initialize Variables.
hitobstacle = 0;
direction = 'i';
head_row = 8;
head_col = 19;
realscore = 0;
foodeaten = 0;

while (direction ~= 'q') && (hitobstacle ~= 1)
    
    % Get the old direction before receiving new input for direction.
    olddirection = direction;
    
    % Get the user input from the figure window.
    pause(.01)
    if ~isempty(get(gcf, 'CurrentCharacter'))
        direction = get(gcf, 'CurrentCharacter');
        figure(fig1);
        clc;
    end
    
    % Move snake according to user input.
    switch direction
        case 'w'
                
            % Check if snake went out of bounds.
            if head_row - 1 < 1
                direction = 'q';

            % Check if snake hit itself or an obstacle.
            elseif (map(head_row - 1, head_col) == '#') ||...
                    (map(head_row - 1, head_col) == '=')
                hitobstacle = 1;

            else
            % Update snake head and move snake in correct direction.
                head_row = head_row - 1;
                map(head_row, head_col) = '=';

                [last_row, last_col] = findsnakeend(map, head_row,...
                                        head_col, direction);
                map(last_row, last_col) = ' ';
            end

        case 'a'
            % Check if snake went out of bounds.
            if head_col - 1 < 1
                direction = 'q';

            % Check if snake hit itself or an obstacle.
            elseif (map(head_row, head_col - 1) == '#') ||...
                    (map(head_row, head_col - 1) == '=')
                hitobstacle = 1;

            else
            % Update snake head and move snake in correct direction.
                head_col = head_col - 1;
                map(head_row, head_col) = '=';

                [last_row, last_col] = findsnakeend(map, head_row,...
                                        head_col, direction);
                map(last_row, last_col) = ' ';
            end
            
        case 's' 
            % Check if snake went out of bounds.
            if head_row + 1 > 15
                direction = 'q';

            % Check if snake hit itself or an obstacle.
            elseif (map(head_row + 1, head_col) == '#') ||...
                    (map(head_row + 1, head_col) == '=')
                hitobstacle = 1;

            else
            % Update snake head and move snake in correct direction.
                head_row = head_row + 1;
                map(head_row, head_col) = '=';

                [last_row, last_col] = findsnakeend(map, head_row,...
                                        head_col, direction);
                map(last_row, last_col) = ' ';
            end
            
        case 'd'
                
            % Check if snake went out of bounds.
            if head_col + 1 > 30
                direction = 'q';

            % Check if snake hit itself or an obstacle.
            elseif (map(head_row, head_col + 1) == '#') ||...
                    (map(head_row, head_col + 1) == '=')
                hitobstacle = 1;

            else
                % Update snake head and move snake in correct direction.
                head_col = head_col + 1;
                map(head_row, head_col) = '=';

                [last_row, last_col] = findsnakeend(map, head_row,...
                                        head_col, direction);
                map(last_row, last_col) = ' ';
            end
            
    end
    
    % Update the map.
    mapanno.String = map;
    % Check if snake ate food.
    result = checkfood(head_row, head_col, food_row, food_col);
    
    % If snake ate food, replace food with snake and generate new food.
    if result == 1
        % Set the eaten food equal to the snake.
        map(food_row, food_col) = '=';
        
        % Generate new piece of food.
        [food_row, food_col] = generatefood();
        while ~(map(food_row, food_col) == ' ')
            % If the generated food is on a snake or hash location,
            % generate a new piece of food.
            [food_row, food_col] = generatefood();
        end
        
        map(food_row, food_col) = 'X';
        
        % Update food eaten
        foodeaten = foodeaten + 1;
        
        % Update score
        realscore = foodeaten * 10;
        
        % Update score on window.
        score = ['Score: ', num2str(realscore)];
        scoreanno.String = score;
    
        % Increase snake length.
        map(last_row, last_col) = '=';
    end
    
    % Set speed of snake.
    pause(.25);
    
    % If user has not given an input, notfiy user.
    if isempty(get(gcf, 'CurrentCharacter'))
        startmsg = 'Press any key to start!';
        noinput = annotation('textbox', [.400 .80 .2 .05], 'String',...
            startmsg, 'FontWeight', 'bold', 'BackgroundColor', 'k', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', ...
        'middle', 'FontSize', 18, 'Color', 'r');
    
    % Create instructions.
    instructions = ['Instructions:'
                    'Q for quit   '
                    'W for up     '
                    'S for down   '
                    'A for left   '
                    'D for right  '];
    noinput2 = annotation('textbox', [.75 .50 .05 .05], 'String', ...
               instructions, 'BackgroundColor', 'k', 'FontSize',25, ...
               'Margin', 0, 'FitBoxToText', 'on', 'FontName', ...
               'FixedWidth', 'FontWeight', 'bold','HorizontalAlignment',...
               'center', 'VerticalAlignment', 'middle', 'Color', 'c');
    else
        noinput.String = '';
        noinput2.String = '';
  
    end
end

figure(fig1)

% Save score.
new_highscore = savescores(realscore);

% If there is a new high score, alert user.
if old_highscore ~= new_highscore
    highscore_string = ['High Score: ', int2str(new_highscore)];
    annotation('textbox', [.4 .74 .2 .05], 'String', highscore_string, ...
    'BackgroundColor', 'g', 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', 'FitBoxToText', 'on', 'FontSize', 18);

    annotation('textbox',[.348 .45 .324 .05],'String','NEW HIGHSCORE!!',...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle',...
    'FontSize', 24, 'BackgroundColor', 'g', 'FontWeight', 'bold')
    
else
    annotation('textbox',[.348 .45 .324 .05],'String','GAME OVER!!',...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle',...
    'FontSize', 24, 'BackgroundColor', 'r', 'FontWeight', 'bold')
end

figure(fig1)
pause(2)
% Close figure window.
close(fig1);
