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

% Create map
mapanno = annotation('textbox', [.42 .20 .18 .55], 'String', map, ...
        'BackgroundColor', '#EDB120', 'FontSize',25, 'Margin', 0, ...
        'FitBoxToText', 'on', 'FontName', 'FixedWidth', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

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
        
        % Update score.
        realscore = realscore + 1;
        
        % Update score on window.
        score = ['Score: ', num2str(realscore)];
        scoreanno.String = score;
    
        % Increase snake length.
        map(last_row, last_col) = '=';
    end
    
    % Set speed of snake.
    pause(.1);
    
    % If user has not given an input, notfiy user.
    if isempty(get(gcf, 'CurrentCharacter'))
        startmsg = 'Press any key to start!';
        noinput = annotation('textbox', [.400 .80 .2 .05], 'String',...
            startmsg, 'FontWeight', 'bold', 'BackgroundColor', 'k', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', ...
        'middle', 'FontSize', 18, 'Color', 'r');
    else
        noinput.String = '';
  
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
pause(5)
% Close figure window.
close(fig1);
