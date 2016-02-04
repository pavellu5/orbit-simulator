function [d,m,y] = JD2date(jd)
%% JD2date - Convert date in gregorian calendar (regular date) to Julian Date.
%   jd ... date in Julian Date   
%   d ... output - day
%   m ... output - month
%   y ... output - year
%
% Source of algorithm - http://quasar.as.utexas.edu/BillInfo/JulianDatesG.html
  Q = jd + 0.5;
  Z = floor(Q);
  W = floor((Z - 1867216.25)/36524.25);
  X = floor(W/4);
  A = Z+1+W-X;
  B = A+1524;
  C = floor((B-122.1)/365.25);
  D = floor(365.25*C);
  E = floor((B-D)/30.6001);
  F = floor(30.6001*E);
  d = floor(B - D - F + (Q - Z));
  M = E -13;
  if M < 1
      m = E -1;
  else
      m = M;
  end    
  if m < 3
      y = C - 4715;
  else
      y = C - 4716;
  end    

end

