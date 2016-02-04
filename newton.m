function oneRoot = newton( handle, start, count )
%%  Newton metod equation solver
%   Numeric solver od equationsusing Newton's method
%
%   handle ... handle function of equation
%   start ... star value of root
%   count ... count of iterations
%   oneRoot ... output - one solution of equation

xk = start;
xk1 = start*3;
err = 0.0001;
k = 0;

    while abs((xk-xk1)/xk) >= err && k < count
        xk = xk1;
        f = handle(xk);
        delta = 1e-5;
        df = (handle(xk+delta)-handle(xk-delta))/(2*delta);
        xk1 = xk - f/df;
        k = k +1;     
    end

    oneRoot = xk1;
end

