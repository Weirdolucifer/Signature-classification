function maps = extract_features( img )

map = zeros(1,12);
bin_img = imbinarize(img);
skeletonImage1 = bwmorph(bin_img, 'thicken', inf);

skeletonImage  = 1-skeletonImage1(:,:);

[h,w] = size(img);
parts =0;
part = zeros(h,w);
isolated = 0;

for i = 2:w-1
    for j = 2:h-1
        
        if (skeletonImage(j,i) ==1 && part(j,i)==0  )
                parts = parts +1;
                part = partition(skeletonImage,part,i,j,w,h,parts);
        end
        
        if (skeletonImage(j,i) ==1 )
            if(skeletonImage(j-1,i)==0 && skeletonImage(j+1,i)==0 && skeletonImage(j,i-1)==0 && skeletonImage(j,i+1)==0)
                isolated = isolated +1;
                             
            end
       end
    end
end

parts = parts - isolated;
[size1,comx,comy] = com(skeletonImage);
[a,b,c,d] = actual_size(1-bin_img(:,:));
centrex = a+b/2;
centrey = c+d/2;

distx = (centrex-comx);
disty = (centrey-comy);
dist = sqrt(distx^2+disty^2);
map(1,1) = comx ;
map(1,2) = comy ;
X = kurtosis(double(skeletonImage));
map(1,3) = kurtosis(X);
% 
map(1,4) = dist;

map(1,5) = parts ;
map(1,6) = isolated;


harris = detectHarrisFeatures(skeletonImage);
map(1,7) = harris.Count;
map(1,8) = size1;
map(1,9) = avgH((1-bin_img(:,:)),a,b,c,d);

X = skewness(double(skeletonImage));
map(1,10) = skewness(X);
map(1,11) = ((b-a)*(d-c)*100000)/(h*w);
maps = map;

end

