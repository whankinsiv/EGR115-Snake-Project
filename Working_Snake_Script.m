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
annotation('textbox', [.400 .9 .2 .05], 'String', 'Snake Game', 'FontWeight', 'bold', 'BackgroundColor', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c');
score = 'Score: ';
annotation('textbox', [.400 .85 .2 .05], 'String', score, 'FontWeight', 'bold', 'BackgroundColor', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c')

% Initialize Variables.
hitobstacle = 0;
direction = 'a';
head_row = 8;
head_col = 19;
realscore = 0;

while (direction ~= 'q')
    
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
                else
                % Update snake head and move snake in correct direction.
                    head_row = head_row - 1;
                    map(head_row, head_col) = '=';
                end
            end
            
        case 'a'
            if olddirection ~= 'd'
                direction = 'd';
                
            else
                
                % Check if snake went out of bounds.
                if head_col - 1 < 1
                    direction = 'q';
                else
                % Update snake head and move snake in correct direction.
                    head_col = head_col - 1;
                    map(head_row, head_col) = '=';
                end
            end
            
        case 's'
            if olddirection ~= 'w'
                direction = 'w';
                
            else
                
                % Check if snake went out of bounds.
                if head_row + 1 > 15
                    direction = 'q';
                else
                % Update snake head and move snake in correct direction.
                    head_row = head_row + 1;
                    map(head_row, head_col) = '=';
                end
            end
            
        case 'd'
            if olddirection ~= 'a'
                direction = 'a';           
                
            else
                
                % Check if snake went out of bounds.
                if head_col + 1 > 30
                    direction = 'q';
                else
                % Update snake head and move snake in correct direction.
                    head_col = head_col + 1;
                    map(head_row, head_col) = '=';
                end
            end
            
    end
    
    % Update the map.
    annotation('textbox', [.42 .20 .18 .55], 'String', map, 'BackgroundColor', '#EDB120', 'FontSize',25, 'Margin', 0, 'FitBoxToText', 'on', 'FontName', 'FixedWidth', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')
    
    % Check if snake ate food.
    result = checkfood(head_row, head_col, food_row, food_col);
    
    % If snake ate food, replace food with air and generate new food.
    if result == 1
        % Set the eaten food equal to the snake.
        map(food_row, food_col) = '=';
        
        % Generate new piece of food.
        [food_row, food_col] = generatefood();
        map(food_row, food_col) = 'X';
        
        % Update score.
        realscore = realscore + 1;
        
        % Update score on window.
        score = ['Score: ', num2str(realscore)];
        annotation('textbox', [.400 .85 .2 .05], 'String', score, 'FontWeight', 'bold', 'BackgroundColor', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 18, 'Color', 'c')
    
        % Increase snake length.
        
    end
    
    % Set speed of snake.
    pause(.60);
end

% Save score.
highscore = savescores(realscore);

% Close figure window.
close(fig1)