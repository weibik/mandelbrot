function [] = mandelbrot(Xmin, Xmax, Ymin, Ymax)
    step = 0.1;
    numOfIt = 100;
    col = "hsv";

    defXmin = Xmin;
    defXmax = Xmax;
    defYmin = Ymin;
    defYmax = Ymax;
    defCol = col;
    defStep = step;
    defNumOfIt = numOfIt;
            
    function [] = compute(Xmin, Xmax, Ymin, Ymax)
        RangeX = Xmin:step:Xmax;
        RangeY = Ymin:step:Ymax;

        [CX ,CY]=meshgrid(RangeX,RangeY);
        C=CX+CY*1.0i;
    
        Z = zeros(size(C)); 
        V = ones(size(C)); 
        for n = 1:numOfIt
            B = abs(Z) <= 2;
            Z(B) = Z(B).^2+C(B); 
            V(B) = V(B)+1; 
        end
    
        imgColors = mod(V,64) + 1;
        image([Xmin,Xmax], [Ymin,Ymax], imgColors);
        axis xy;
        axis equal;
        axis off;
        colormap(col)
     
        
        text(2/3, Ymax*6/7, sprintf('num=%0.1f',numOfIt));
        text(2/3, Ymax*5/7, sprintf('RangeX=%0.1f - %0.1f',Xmin, Xmax));
        text(2/3, Ymax*4/7, sprintf('RangeY=%0.1f - %0.1f',Ymin, Ymax));
        text(2/3, Ymax*3/7, sprintf('step=%0.03f', step));

    end

    compute(Xmin, Xmax, Ymin, Ymax)

    while true
        [a1, b1, choise]=ginput(1);
        % ZOOM
        if choise <= 3                                                 
            [a2, b2] = ginput(1);

            if(a1 < a2 && b1 < b2)
                Xmin = a1;
                Xmax = a2;
                Ymin = b1;
                Ymax = b2;
            elseif(a1 < a2 && b1 > b2)
                Xmin = a1;
                Xmax = a2;
                Ymin = b2;
                Ymax = b1;
            elseif(a1 > a2 && b1 < b2)
                Xmin = a2;
                Xmax = a1;
                Ymin = b1;
                Ymax = b2;
            else
                Xmin = a2;
                Xmax = a1;
                Ymin = b2;
                Ymax = b1;
            end
            
            compute(Xmin, Xmax, Ymin, Ymax)
        else
            switch choise
                % EXIT
                case 'q', 'Q';
                    return;
                % INCREASE NUM OF ITERATIONS
                case '+'
                    numOfIt = numOfIt*2;
                    compute(Xmin, Xmax, Ymin, Ymax)
                % DECREASE NUM OF ITERATIONS
                case '-'
                    numOfIt = numOfIt/2;
                    compute(Xmin, Xmax, Ymin, Ymax)
                % RESTORE DEFAULT IMAGE
                case {'d' 'D'}
                    col = defCol;
                    step = defStep;
                    numOfIt = defNumOfIt;
                    compute(defXmin, defXmax, defYmin, defYmax)
                % INCREASE STEP = INCREASE RESOLUTION
                case {'s' 'S'}
                    step = step/5;
                    compute(Xmin, Xmax, Ymin, Ymax)
                % DECREASE STEP = DECREASE RESOLUTION
                case {'a' 'A'}
                    step = step*5;
                    compute(Xmin, Xmax, Ymin, Ymaxl)
                % CHANGE COLORMAP
                case {'c' 'C'}
                     combined = ["jet" "hsv" "hot" "cool" "spring" "summer" "autumn" "winter" "gray" "bone"];
                     ind = randperm(length(combined), 1);
                     col = combined(ind);
                     compute(Xmin, Xmax, Ymin, Ymax);
            end        
        end
    end
end