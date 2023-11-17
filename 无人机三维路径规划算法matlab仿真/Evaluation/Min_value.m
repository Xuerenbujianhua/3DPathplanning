%Made by 雪人不见花  
%2023/03/15
%Wishing you to encourage yourself！

%返回三个数中最小值的位置
function minvalue_index = Min_value(a,b,c)
  if(a<=b && a<=c)  
      minvalue_index = 1; 
  else
      if(b<=a && b <=c)
           minvalue_index = 2;
      else
           if(c<=a && c <=b)
             minvalue_index = 3;
           end
      end
  end
end