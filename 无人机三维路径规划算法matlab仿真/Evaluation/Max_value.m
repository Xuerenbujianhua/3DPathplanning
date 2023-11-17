%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%返回三个数中最小值的位置
function maxvalue_index = Max_value(a,b,c)
  if(a>b && a>c)  
      maxvalue_index = 1; 
  else
      if(b>a && b >c)
           maxvalue_index = 2;
      else
           if(c>a && c>b)
             maxvalue_index = 3;
           end
      end
  end
end