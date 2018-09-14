function [FOOTSUM,footrotateSum,Times]=FP_process(ustar,vv_Vector,Lo,windir,zo,zH,d,FX,FY,Map,PlotVec)
% This process is computing the foot print in half hour intervals.
% The foot print is "where the wind is coming from"
% Inputs for this process are : year
%                               ustar data from fluxW file, year long format
%                               ww data
%                               Obukhov length
%                               wind direction data
%                               roughness length and displacment hight
%                               (computed in the RoughLengthCalc.m)
%                               Map data, FX, FY, and the map itself
%                               Optional: PlotVec. 0 for don't plot this
%                               half hour, 1 for plot it
% 
% The output of this process is a matrix the atributes percent of "where the wind is coming from"
% to the different patch type with the following code:
% Patch type code to patch canopy properties data in ForestCanopy_data.m 

if nargin==10
    PlotVec=zeros(size(ustar));
end

% NumValFile=48;
sv=sqrt(vv_Vector);

% ly=leapyear(year);
% DaysInYear=365+ly;
footrotateSum=zeros(size(Map));
FOOTSUM=nan(length(ustar),length(PatchIndex(Map)));
Times=0;
for i=1:length(ustar)
    if ~isnan(ustar(i)*Lo(i)*sv(i)*zo*zH*d*windir(i))
        [~,~,~,footrotate,~,~,FOOTSUM(i,:),timesteps]=Hsieh2DRotate_special(ustar(i),Lo(i),sv(i),zo,zH,d,windir(i),PlotVec(i), FX, FY, Map,0);
        Times=Times+timesteps;
    end
    if mod(i,48*10)==0    
        disp(['Footprint complete for day ' num2str(floor(i/48))])
    end
    footrotate(isnan(footrotate))=0;
    footrotateSum=footrotateSum+footrotate;
end
end