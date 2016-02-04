function [x,y,z] = simulator(elements, t)
%% SIMULATOR - compute coordinates of planet in considered time
%   elements vector [a,e,i,omega,linedOmg,l]
%       a ... semi-major axis [AU]
%       e ... excentricity [degree]
%       i ... inclination [degree]
%       omega ... Longitude of ascending node [degree]
%       linedOmg ...Longitude of perihelion [degree]
%       l ... Mean Longitude [degree]
%   t ... considered epoch - vector or single number in JD [JD]

%% Konstants
% radians to 1 degree
rad = 0.0174532925;
% meters to one AU
AU = 1.49597870691e11;
%t0 for JD2000  [JD]
t0 = 2451545.0;
% standard gravitational parameter of central body (sun)
mu = 1.32712440041e20;

%% Orbital elements
% semi-major axis [m]
a =  elements(1)*AU; 
% eccentricity [1]
e = elements(2);
% Inclination [rad]
i = elements(3)*rad;
% Longitude of ascending node (LAN) [rad]
omega = elements(4)*rad;
% Argument of periapsis [rad] = Longitude of perihelion - LAN(omega)
omg = elements(5)*rad - omega;
% Mean anomaly M0 = M(0) [rad] at t0 [JD] 
% MO = Mean Longitude-Argument of periapsis(omg)- LAN(omega)
M0 = elements(6)*rad - omg - omega;

%% Calculation
% count of steps
n = length(t);
% delta t
deltaT = 86400.*(t-t0);
% mean anomaly
M = M0 + deltaT.*sqrt(mu/a^3);
% normalization to interval from 0 to 2*pi
M = mod(M, 2*pi);
% solving Kepler's equation
E = nan(1,n);
for k = 1:n
    fcn = @(x) x - e*sind(x)-M(k);
    E(k) = newton(fcn, M(k), 50);
end

% true anomaly nu
nu = 2*atan2(sqrt(1+e).*sin(E/2),sqrt(1-e).*cos(E/2));
% distance to the central body
rc = a*(1 - e*cos(E));
% orbital frame position vectors
o1 = rc.*cos(nu);
o2 = rc.*sin(nu);
% heliocentrical rectagular coordinates
X = o1.*(cos(omg)*cos(omega)-sin(omg)*cos(i)*sin(omega))-o2.*(sin(omg)*cos(omega)+cos(omg)*cos(i)*sin(omega));
Y = o1.*(cos(omg)*sin(omega)+sin(omg)*cos(i)*cos(omega))+o2.*(cos(omg)*cos(i)*cos(omega)-sin(omg)*sin(omega));
Z = o1.*(sin(omg)*sin(i)) + o2.*(cos(omg)*sin(i));
% conversion from meters to AU
x = X./AU;
y = Y./AU;
z = Z./AU;


end
