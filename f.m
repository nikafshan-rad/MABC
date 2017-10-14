function ff=f(x,funnum)
n=length(x);
i2=1:n;
if funnum == 1
    %% 
    n=length(x);
    s=0;
    for i=1:n
       s=s+x(i)^2;
    end
    ff=s;
elseif funnum == 2
    n = length(x);
    s = 0;
    for i = 1:n
        s = s + (10 ^ 6)^((i-1)/(n-1))*x(i)^2;
    end
    ff = s;
elseif funnum == 3
    n = length(x);
    s = 0;
    for i = 1:n
       s = s + i * x(i) ^ 2;
    end
    ff = s;
elseif funnum == 4
    n = length(x);
    s = 0;
    for i = 1:n
       s = s + abs(x(i)^(i+1)); 
    end
    ff = s;
elseif funnum == 5
     for i = 1:n
       ff = sum(abs(x(i))) + prod(abs(x(i)));
     end  
elseif funnum == 6
     for i = 1:n
        ff = max(abs(x(i)));
     end   
elseif funnum == 7
     for i = 1:n
        ff = sum(floor(x(i) + 0.5).^2);
     end   
elseif funnum == 8
    n = length(x);
    s = 0;
    for i = 1:n
       s = s + i * x(i)^4; 
    end
    ff = s;
elseif funnum == 9
    n = length(x);
    s = 0;
    for i = 1:n
       s = s + i * x(i)^4 + rand(1); 
    end
    ff = s;
elseif funnum == 10
    n = length(x);
    s = 0;
    for i = 1:(n - 1)
        s = s + (100 * ((x(i+1) - x(i)^2)^2) + (x(i) - 1)^2);
    end
    ff = s;
elseif funnum == 11
     for i = 1:n
         ff=sum(x(i).^2 - 10 * cos(2 * pi .* x(i)) + 10);
     end    
elseif funnum == 12
    for i = 1:n
       if abs(x(i))<0.5
           y(i)=x(i);
       else
           y(i)=round(2*x(i))/2;
       end
    end
    ff = sum(y .^ 2 - 10 * cos(2 * pi .* y) + 10);
elseif funnum == 13
    for i = 1:n
       ct(i)=cos(x(i)/sqrt(i));
    end
    ff = 1/4000 * (sum(x(i).^2) - prod(ct)) + 1;
elseif funnum == 14
    s = 0;
    for i = 1:n
       s = s + x(i) * sin(sqrt(abs(x(i))));
    end
    ff = 418.98288727243369 * n - s;
elseif funnum == 21
    s = sum(x .^ 2);
    ff = 0.5 + sin((sqrt(s) - 0.5)/(1 + 0.001*s).^2)^2;
elseif funnum == 22
    for i=1:n
      ff = 1/n * sum(x(i).^4 - 16.*x(i).^2 + 5.*x(i));
    end  
elseif funnum == 23
    s = 0;
    for i=1:n
        s = s + (sin(x(i))*(sin(i*x(i).^2/pi))^20);
    end
    ff = -s;
end
end