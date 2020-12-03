% Create map.
map = ['##                          ##'
       '#                            #'
       '                              '
       '                              '
       '                              '
       '                              '
       '                              '
       '                  ==          '
       '                              '
       '                              '
       '                              '
       '                              '
       '                              '
       '#                            #'
       '##                          ##'];
   
% Request user input for difficulty.


% Generate first piece of food.
[food_row, food_col] = generatefood();
map(food_row, food_col) = 'X';

% Setup figure window.
fig1 = figure('Name','Snake Game','NumberTitle','off','Color','k');
set(fig1, 'MenuBar', 'none', 'Position',  get(0,'ScreenSize'));

annotation('textbox', [.400 .9 .2 .05], 'String', 'Snake Game', ...
    'FontWeight', 'bold', 'BackgroundColor', 'k', 'HorizontalAlignment',...
    'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c');

score = 'Score: ';
annotation('textbox', [.400 .85 .2 .05], 'String', score, 'FontWeight',...
    'bold', 'BackgroundColor', 'k', 'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c');

old_highscore = savescores();
highscore_string = ['High Score: ', int2str(old_highscore)];
annotation('textbox', [.4 .74 .2 .05], 'String', highscore_string, ...
    'BackgroundColor', 'y', 'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', 'FitBoxToText', 'on', 'FontSize', 18);

% Initialize Variables.
hitobstacle = 0;
direction = 'a';
head_row = 8;
head_col = 19;
realscore = 0;

while (direction ~= 'q') && (hitobstacle ~= 1)
    
    % Get the old direction before receiving new input for direction.
    olddirection = direction;
    
    % Get the user input from the figure window.
    pause(.1)
    if ~isempty(get(gcf, 'CurrentCharacter'))
        direction = get(gcf, 'CurrentCharacter');
        figure(fig1);
        clc;
    end
    
    % Move snake according to user input.
    switch direction
        case 'w'
            if olddirection ~= 's'
                direction = 's';

            else
                
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
            end
            
        case 'a'
            if olddirection ~= 'd'
                direction = 'd';
                
            else
                
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
            end
            
        case 's'
            if olddirection ~= 'w'
                direction = 'w';
                
            else
                
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
            end
            
        case 'd'
            if olddirection ~= 'a'
                direction = 'a';           
                
            else
                
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
            
    end
    
    % Update the map.
    annotation('textbox', [.42 .20 .18 .55], 'String', map, ...
        'BackgroundColor', '#EDB120', 'FontSize',25, 'Margin', 0, ...
        'FitBoxToText', 'on', 'FontName', 'FixedWidth', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    
    % Check if snake ate food.
    result = checkfood(head_row, head_col, food_row, food_col);
    
    % If snake ate food, replace food with snake and generate new food.
    if result == 1
        % Set the eaten food equal to the snake.
        map(food_row, food_col) = '=';
        
        % Generate new piece of food.
        [food_row, food_col] = generatefood();
        while (map(food_row, food_col) == '=') ||...
                (map(food_row, food_col) == '#') 
            % If the generated food is on a snake or hash location,
            % generate a new piece of food.
            [food_row, food_col] = generatefood();
        end
        
        map(food_row, food_col) = 'X';
        
        % Update score.
        realscore = realscore + 1;
        
        % Update score on window.
        score = ['Score: ', num2str(realscore)];
        annotation('textbox', [.400 .85 .2 .05], 'String', score, ...
            'FontWeight', 'bold', 'BackgroundColor', 'k', ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', ...
            'middle', 'FontSize', 18, 'Color', 'c')
    
        % Increase snake length.
        map(last_row, last_col) = '=';
    end
    
    % Set speed of snake.
    pause(.01);
end

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

pause(5)
% Close figure window.
close(fig1);