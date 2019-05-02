function part = partition(skeletonImage,part,i,j,m,n,count)
  if part(j,i)==0 
      
      part(j,i) = count;
      if(skeletonImage(j+1,i)==1 && part(j+1,i)==0)
        part = partition(skeletonImage,part,i,j+1,m,n,count);
      end
      if(skeletonImage(j-1,i)==1 && part(j-1,i)==0 )
        part = partition(skeletonImage,part,i,j-1,m,n,count);
      end
      if(skeletonImage(j,i-1)==1 && part(j,i-1)==0 )
        part = partition(skeletonImage,part,i-1,j,m,n,count);
      end
      if(skeletonImage(j,i+1)==1 && part(j,i+1)==0)
        part = partition(skeletonImage,part,i+1,j,m,n,count);
      end
      if(skeletonImage(j-1,i-1)==1 && part(j-1,i-1)==0)
        part = partition(skeletonImage,part,i-1,j-1,m,n,count);
      end
      if(skeletonImage(j-1,i+1)==1 && part(j-1,i+1)==0)
        part = partition(skeletonImage,part,i+1,j-1,m,n,count);
      end
      if(skeletonImage(j+1,i+1)==1 && part(j+1,i+1)==0)
        part = partition(skeletonImage,part,i+1,j+1,m,n,count);
      end
      if(skeletonImage(j+1,i-1)==1 && part(j+1,i-1)==0)
        part = partition(skeletonImage,part,i-1,j+1,m,n,count);
      end
    
  end
end



