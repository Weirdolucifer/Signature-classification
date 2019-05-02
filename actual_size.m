function [ xmin,xmax,ymin,ymax ] = actual_size( I )

    [height,width] = size(I);
    
    minx = 10000;
    miny = 10000;
    maxx = 0;
    maxy = 0;
    for i=1:height - 1
        for j=1 : width - 1
            if(I(i,j)==1)
                if(j<minx)
                    minx = j;
                end
                if(j>maxx)
                    maxx = j;
                end
                if(i<miny)
                    miny = i;
                end
                if(i>maxy)
                    maxy = i;
                end
            end
        end
    end
xmin = minx;
xmax = maxx;
ymin = miny;
ymax = maxy;
end

