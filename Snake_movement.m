x = 10:11;
y = ones(1, length(x)) * 10;
direction = 'a';

while direction ~= 'q'

    olddirection = direction;
    figure(gcf)
    direction = get(gcf, 'CurrentCharacter');
    
    clf('reset')
    
    if ~isempty(x)
        line = animatedline(x, y, 'Color', 'g', 'LineWidth', 10);
        axis([0 20 0 20]);
    end
    if  direction == 'd'
        
        if isempty(x)
            if olddirection == 'w'
                x = x1(end):x1(end) + 1;
            elseif olddirection == 's'
                x = x1(1):x1(1) + 1;
            end
            
            y = ones(1,length(x1)) * y1(1);
            clear x1
            clear y1
        end
        
        line = animatedline(x, y, 'Color', 'g', 'LineWidth', 10);
        x = x + 1;
        
    elseif direction == 'a'
        if isempty(x)
            if olddirection == 'w'
                x = x1(end):x1(end) + 1;
            elseif olddirection == 's'
                x = x1(1):x1(1) + 1; 
            end
            
            y = ones(1,length(x1)) * y1(1);
            clear x1
            clear y1
        end
        
        line = animatedline(x, y, 'Color', 'g', 'LineWidth', 10);
        x = x - 1;
        
    end
    
    if (direction == 'w')
        
        if ~exist('y1', 'var')
            y1 = y(1):y(1)+ 1;
        end
        
        x = x(2:end);
        y = y(2:end);
            
        if ~exist('x1', 'var')
            if olddirection == 'd'
                x1 = ones(1, length(y1))* x(end);
            elseif olddirection == 'a'
                x1 = ones(1, length(y1))* x(1);
            end
        end        
        
        line1 = animatedline(x1, y1, 'Color', 'g', 'LineWidth', 10);
        axis([0 20 0 20]);
        y1 = y1 +1;
            
    elseif (direction == 's')
        
        if ~exist('y1', 'var')
            y1 = y(1):y(1) + 1;
        end
        
        x = x(2:end);
        y = y(2:end);
        
        if ~exist('x1', 'var') 
            if olddirection == 'd'
                x1 = [x(end), x(end)];
            elseif olddirection == 'a'
                x1 = [x(1), x(1)];
            end

        end
        
        line1 = animatedline(x1, y1, 'Color', 'g', 'LineWidth', 10);
        axis([0 20 0 20]);
        y1 = y1 - 1;
    end
    
    
    pause(.5)
end
