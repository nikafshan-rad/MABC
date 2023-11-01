clc;
clear all;
%% Hi
%% Problem Definition
SN = 10;                        % Number of Employed Bees
n = 10;                         % Number of Flowers in Each Food Source
X = [SN n];                     % Food Source
V = [SN n];                     % New Food Source for Worker Bee
U = [SN n];                     % New Food Source for Onlooker Bee
Trial = zeros(SN);              % Counter for Abandonment
Cycle = 1;
Max_Cycle = 180;
Best_ABC = zeros(Max_Cycle);	% Best Solution
Sum = zeros(SN);
p = zeros(SN);                  % Probability of each Food Source
Pre_Val = 0.5;                  % Pre Determined Value For Selecting Food Source by Onlooker Bees
Max_Trial = 30;                 % Maximum Number of Abandonment Trial
Sol = zeros(SN);                % Solution Value
Max_Iteration = 1;
Result = zeros(Max_Iteration , Max_Cycle);

%% Problem Definition: For Initialization in MABC Algorithm
Max_K = SN;
ch = zeros(Max_K , n);
O_X = [SN n];             	% Opposition of Food Source
X_Min = zeros(n);
X_Max = zeros(n);

num = input('Write the Number of Function: ');

%% ABC Algorithm
% Initialization of the Population
for i = 1:SN
    for j = 1:n
        X(i , j) = j + rand(1) * (n - j);
    end
end

while Cycle <= Max_Cycle
    
	% Produce a New Food Source Population for Employed Bees
    for i = 1:SN
		Flag = false;           % Improve in Food Resource Checker
        for j = 1:n
            phi = -1 + 2 * rand(1 , 1);
            k = randi(10 , 1 , 1);
            if k == i
				k = randi(10 , 1 , 1);
            end
            V(i , j) = X(i , j) + phi * (X(i , j) - X(k , j));
        end
		
        for j = 1:n
			if X(i , j) <= V(i , j)
                X(i , j) = V(i , j);
                Flag = true;
            end
        end
		
        if Flag
            %Trial(1 , i) = Trial(1 , i) + 1;
            Trial(i) = 0;
            Flag = false;
        else
            Trial(i) = Trial(i) + 1;
        end
    end
    
	% Calculating Probability Values
    for i = 1:SN
        for j = 1:n
            
            Sum(i) = Sum(i) + f(X(i , :) , num);            %F(2)
            
        end
    end
    Total = 0;
    for i = 1:SN
        Total = Total + Sum(i);
    end
    p(i) = Sum(i) / Total;
    
    % Produce a New Food Source Population for Onlooker Bees
	t = 0;
	i = 1;
    C = 0;
	while (t <= SN) && (C <= Max_Cycle)
		if p(i) > Pre_Val
			Flag = false;           % Improve in Food Resource Checker
			for j = 1:n
				phi = -1 + 2 * rand(1 , 1);
				k = randi(10 , 1 , 1);
				if k == i
					k = randi(10 , 1 , 1);
				end
				U(i , j) = X(i , j) + phi * (X(i , j) - X(k , j));
			end
			
			for j = 1:n
				if X(i , j) <= U(i , j)
					X(i , j) = U(i , j);
					Flag = true;
				end
			end
			
			if Flag
				%Trial(1 , i) = Trial(1 , i) + 1;
				Trial(i) = 0;
				Flag = false;
			else
				Trial(i) = Trial(i) + 1;
			end
			t = t + 1;
		end
		C = C + 1;
		i = i + 1;
		if i > SN
			i = 1;
		end
	end
	
	% Determine Scout Bees
	if max(Trial(i)) > Max_Trial
		for j = 1:n
			X(i , j) = j + rand(1) * (n - j);
		end
	end
	
	% Determine the Best Solution
    for i = 1:SN
        for j = 1:n
            
            Sol(i) = Sol(i) + f(X(i , :) , num);            %F(2)
        
        end
    end
    Total = 0;
    for i = 1:SN
        Total = Total + Sol(i);
    end
    Sol(i) = Sol(i) ./ Total;
    
	for i = 1:SN
		if Best_ABC(Cycle) < Sol(i)
			Best_ABC(Cycle) = Sol(i);
		end
    end
    
    fprintf ('Cycle & BestSolution of ABS is: %g %g \n', Cycle , Best_ABC(Cycle));
    
	Cycle = Cycle + 1;
	
end

%% MABC Algorithm
for Iteration = 1:Max_Iteration
	% Variables Initialization
	Trial = zeros(SN);
	Cycle = 1;
	Best_MABC = zeros(Max_Cycle);
	Sum = zeros(SN);
	p = zeros(SN);
	Sol = zeros(SN);
	
	% Initialization of the Population
	for i = 1:SN
		for j = 1:n
			ch(1 , j) = rand(1);
			K = 0;
			for k = 1:Max_K
				ch(k + 1 , j) = sin(pi * ch(k , j));
			end
			X(i , j) = j + ch(k + 1 , j) * (n - j);
		end
	end
	
	for j = 1:n
		X_Max(j) = X(1 , j);
		X_Min(j) = X(1 , j);
	end
	
	for j = 1:n
		for i = 2:SN
			if X(i , j) > X_Max(j)
				X_Max(j) = X(i , j);
			end
			
			if X(i , j) < X_Min(j)
				X_Min(j) = X(i , j);
			end
		end
	end
	
	for i = 1:SN
		for j = 1:n
			O_X(i , j) = X_Min(j) + X_Max(j) - X(i , j);
		end
	end
	
	for i = 1:SN
		for j = 1:n
			if O_X(i , j) > X(i , j)
				X(i , j) = O_X(i , j);
			end
		end
	end
	
	while Cycle <= Max_Cycle
		
		% Produce a New Food Source Population for Employed Bees
		for i = 1:SN
			Flag = false;           % Improve in Food Resource Checker
			for j = 1:n
				phi = -1 + 2 * rand(1 , 1);
				k = randi(10,1,1);
				if k == i
					k = randi(10,1,1);
				end
				V(i , j) = X(i , j) + phi * (X(i , j) - X(k , j));
			end
			
			for j = 1:n
				if X(i , j) <= V(i , j)
					X(i , j) = V(i , j);
					Flag = true;
				end
			end
			
			if Flag
				%Trial(1 , i) = Trial(1 , i) + 1;
				Trial(i) = 0;
				Flag = false;
			else
				Trial(i) = Trial(i) + 1;
			end
		end
		
		% Calculating Probability Values
		%for i = 1:SN
		%	for j = 1:n
		%		
		%		Sum(i) = Sum(i) + f(X(i , :) , num);            %F(2)
		%	
		%	end
		%end
		%Total = 0;
		%for i = 1:SN
		%	Total = Total + Sum(i);
		%end
		%p(i) = Sum(i) / Total;
		
		for i = 1:SN
			p(i) = 0.7;
		end
		% Produce a New Food Source Population for Onlooker Bees
		t = 0;
		i = 1;
		C = 0;
		while (t <= SN) && (C <= Max_Cycle)
			if p(i) > Pre_Val
				Flag = false;           % Improve in Food Resource Checker
				for j = 1:n
					phi = -1 + 2 * rand(1 , 1);
					k = randi(10 , 1 , 1);
					if k == i
						k = randi(10 , 1 , 1);
					end
					U(i , j) = X(i , j) + phi * (X(i , j) - X(k , j));
				end
				
				for j = 1:n
					if X(i , j) <= U(i , j)
						X(i , j) = U(i , j);
						Flag = true;
					end
				end
				
				if Flag
					%Trial(1 , i) = Trial(1 , i) + 1;
					Trial(i) = 0;
					Flag = false;
				else
					Trial(i) = Trial(i) + 1;
				end
				t = t + 1;
			end
			C = C + 1;
			i = i + 1;
			if i > SN
				i = 1;
			end
		end
		
		% Determine Scout Bees
		%if max(Trial(i)) > Max_Trial
		%	for j = 1:n
		%		X(i , j) = j + rand(1) * (n - j);
		%	end
		%end
		
		% Determine the Best Solution
		for i = 1:SN
			for j = 1:n
				
				Sol(i) = Sol(i) + f(X(i , :) , num);            %F(2)
				
			end
		end
		Total = 0;
		for i = 1:SN
			Total = Total + Sol(i);
		end
		Sol(i) = Sol(i) ./ Total;
		
		for i = 1:SN
			if Best_MABC(Cycle) < Sol(i)
				Best_MABC(Cycle) = Sol(i);
			end
		end
		
		fprintf ('Cycle & BestSolution of MABC: %g %g \n', Cycle , Best_MABC(Cycle));
		
		Result(Iteration , Cycle) = Best_MABC(Cycle);
		
		Cycle = Cycle + 1;	
	end
end

% Calculating Average & Standard Deviation
Avr = 0;
for i = 1:Max_Iteration
	for j = 1:Max_Cycle
		Avr = Avr + Result(i , j);
	end
end

Avr = Avr / (Max_Iteration * Max_Cycle);				% Average

S1 = 0;
S2 = 0;
for i = 1:Max_Iteration
	for j = 1:Max_Cycle
		S1 = S1 + Result(i , j) ^ 2;
		S2 = S2 + Result(i , j);
	end
end

% Standard Deviation
SD = sqrt(((Max_Iteration * Max_Cycle) * S1 - (S2 ^ 2)) / ((Max_Iteration * Max_Cycle) * (Max_Iteration * Max_Cycle - 1)));

fprintf('Average & Standard Deviation Result: %g %g \n' , Avr , ' - ' , SD);

%% Plot the Final Result

Best_ABC = 1 ./ Best_ABC;
Best_MABC = 1 ./ Best_MABC;

semilogy(Best_ABC  , '--r' , 'LineWidth' , 2);
hold on;
semilogy(Best_MABC , '--g' , 'LineWidth' , 2);
xlabel('Cycle');
ylabel('Best Solution');