function snake_speed = difficulty()

success = 0;

difficulty = input('Please choose game difficulty. (Easy / Medium / Hard): ', 's');
while success == 0

    if (difficulty(1) == 'E') || (difficulty(1) == 'e')
        snake_speed = .3;
        success = 1;
    elseif (difficulty(1) == 'M') || (difficulty(1) == 'm')
        snake_speed = .2;
        success = 1;
    elseif (difficulty(1) == 'H') || (difficulty(1) == 'h')
        snake_speed = .15;
        success = 1;
    else
        fprintf('\nYou failed to enter a valid character... Try again.\n')
        difficulty = input('Please choose game difficulty. (Easy / Medium / Hard): ', 's');
        success = 0;
    end
end
