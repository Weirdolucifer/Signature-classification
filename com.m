function [sum1, xarg ,yarg ] = com( I )
[height,width] = size(I);
sum = 0;
xval = 0;
yval = 0;

for i=2:width-1
    for j=2:height-1
        if(I(j,i)==1)
            sum=sum+1;
            xval = xval+i;
            yval = yval+j;
        end
    end
end
xarg = xval/sum;
yarg = yval/sum;
sum1 = sum;

end

