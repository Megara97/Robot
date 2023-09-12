function [DH] = dhg(theta,d,a,alfa)
DH=[cosd(theta) -cosd(alfa)*sind(theta) sind(alfa)*sind(theta) a*cosd(theta);
    sind(theta)  cosd(alfa)*cosd(theta) -sind(alfa)*cosd(theta) a*sind(theta);
    0 sind(alfa) cosd(alfa) d;
    0 0 0 1];  
end