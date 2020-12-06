function highscore = savescores(score)

% If no input arguments are provided, just return highscore.
if nargin == 0
    
    fid1 = fopen('scores.txt', 'rt');
    fgetl(fid1);
    highscore = 0;
    numberoflines = 1;
    
    % Find number of lines in the file
    while ~feof(fid1)
        numberoflines = numberoflines + 1;
        fgetl(fid1);
    end
    
    frewind(fid1);
    
    % Search each line in the file for the highest score
    for p = 1:numberoflines
        current_line = fgetl(fid1);
        current_score = str2double(current_line(26:end));

        if current_score > highscore
            highscore = current_score;
        end
    end
    
elseif nargin == 1
    
    % Getting Time
    time = clock;
    month = time(2);
    day = time(3);
    year = time(1);
    hour = time(4);
    minutes = time(5);

    % Creating file if it doesnt exist.
    if ~exist('scores.txt', 'file')

        fid1 = fopen('scores.txt', 'wt');
        fprintf(fid1, 'Scores for snake game:');
        fprintf(fid1, '\nHigh Score: 0  ');
        fclose(fid1);
    end

    % Inputing new score.
    fid1 = fopen('scores.txt', 'at');
    if minutes < 10
        if hour < 10
            fprintf(fid1, '\n%d/%d/%d | 0%d:0%d Score: %d',month,day,year,...
            hour, minutes, score);

        elseif hour >= 10
            fprintf(fid1, '\n%d/%d/%d | %d:0%d Score: %d',month,day,year,hour,...
            minutes, score);
        end

    elseif minutes >= 10
        if hour < 10
            fprintf(fid1, '\n%d/%d/%d | 0%d:%d Score: %d',month,day,year,...
            hour, minutes, score);

        elseif hour >= 10
            fprintf(fid1, '\n%d/%d/%d | %d:%d Score: %d',month,day,year,...
            hour, minutes, score);
        end
    end
    fclose(fid1);

    % High Scores Part
    fid1 = fopen('scores.txt', 'rt');
    fgetl(fid1);
    highscore = 0;
    numberoflines = 1;
    
    % Find number of lines in the file
    while ~feof(fid1)
        numberoflines = numberoflines + 1;
        fgetl(fid1);
    end
    
    frewind(fid1);
    
    % Search each line in the file for the highest score
    for p = 1:numberoflines
        current_line = fgetl(fid1);
        current_score = str2double(current_line(26:end));

        if current_score > highscore
            highscore = current_score;
        end
    end

    frewind(fid1);

    % Inputing High Scores Part
    header = fgetl(fid1);
    fgetl(fid1);
    body = fscanf(fid1, '%c');

    fclose(fid1);
    fid1 = fopen('scores.txt', 'wt');
    fprintf(fid1, '%c', header);
    fprintf(fid1, '\nHigh Score: %d\n', highscore);
    fprintf(fid1, '%c', body);

    fclose(fid1);
end







