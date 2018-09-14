%plotClimFoot
%Written by Tim Morin, April 2015
%Contact: morin.37@buckeyemail.osu.edu
%Last modified: August 2015
%
%Given climactic variables and a map with X and Y vectors, generates a
%breakdown of what percent of the signal came from using a contour map.
%Contour interval is definted by user as grp.
%
%NOTE: Tower location must be center pixel of the map (and must be an odd
%number of pixels in X and Y directions).
%
%ustar - turbulent velocity [m/s]
%vv - crosswind variation [m/s]
%L - Obukhov length [m]
%wind_dir - wind direction, degrees from north, clockwise positive [deg]
%zo - Roughness length [m]
%zH - Measurement height [m]
%d - Displacement height [m]
%FX - X distance from tower (negative to the west, positive east, tower at 0 [m]
%FY - Y distance from tower (negative south, postive north, tower at 0 [m]
%Map - Pixel map of tower with different landcover types indicated by different values
%PlotVec - True/false vector with true values on specific half hours to
%plot a footprint pattern for. Usually all false. [boolean]

clear all
%% Test variables:
%load('TestVars.mat')
%% Footprint process
[FOOTSUM_SD,footrotateSD,TimesSD]=FP_process(ustar,vv,L,wind_dir,z0,zH,d,FX,FY,WetlandMap,PlotVec);

%% Contour map
pixelPerc = footrotateSD/TimesSD;
grp=10;                                         %Integer. Spacing of contours

[climFoot]=footprint_perc_map(WetlandMap,pixelPerc,grp,1);