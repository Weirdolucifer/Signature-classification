function height = avgH( I,a,b,c,d )
[h,w] = size(I);

sh = 0;

for i=a : b
    min = d;
    max = c;
    flag = 0;
    for j = c : d
        if (I(j,i)==1)
            flag =1;
          if(j<min)
              min =j;
          end
          if(j>max)
              max = j;
          end
        end
    end
    
    if(flag == 1)
        sh = sh+max-min;
    end  
end

height = (sh*1.0)/(d-c+1);

end

