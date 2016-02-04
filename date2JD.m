function jd = date2JD(d,m,y)
%% date2JD - Convert date in gregorian calendar (regular date) to Julian Date.
%   d ... day
%   m ... month
%   y ... year
%   jd ... output - date in Julian Date
%
%   Source of algorithm - http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
    D = d;
    if m < 3
        M = m + 12;
        Y = y-1;    
    else
        M = m;
        Y = y;
    end    
    A = floor(Y/100);
    B = floor(A/4);
    C = floor(2-A+B);
    E = floor(365.25*(Y+4716));
    F = floor(30.6001*(M+1));
    jd = C+D+E+F-1524.5;
end

