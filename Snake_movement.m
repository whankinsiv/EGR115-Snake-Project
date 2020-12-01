x = 10:11;
y = [10, 10];
direction = 'w'
line = animatedline(x, y, 'Color', 'g', 'LineWidth', 10);
while direction ~= 'q'
    lengthx = length(x);
    y = [10, 10]
    
    olddirection = direction;
    figure(gcf)
    direction = get(gcf, 'CurrentCharacter')
    
    clf('reset')
    line = animatedline(x, y, 'Color', 'g', 'LineWidth', 10);
    axis([0 20 0 20]);
    x = x +1;
    pause(2)
end