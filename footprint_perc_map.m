function [climFoot]=footprint_perc_map(Map,pixelPerc,grp,plotYN)
%[climFoot]=footprint_perc_map(Map,pixelPerc,grp,plotYN)
%Written by Tim Morin Aug 2015
%Using a map with unique patch indicies and a percent signal from each
%pixel, generates evenly spaced contours with which to create a clean plot.
%Map - Map with each landcover indicated by a different integer (mXn)
%pixelPerc - Fraction of the signal occurring from each pixel in Map (mXn)
%grp - interval spacing of output contours (ingeger)
%plotYN - yes/no toggle to enable/disable the final plot (boolean)
%climFoot - Final contour map (mXn)

percOpts  = sort(unique(pixelPerc),'descend');
tempMap=nan(size(Map));
for i=1:length(percOpts)
    curPerc=percOpts(i);
    good=pixelPerc>=curPerc;
    score=sum(sum(pixelPerc(good)))*100;
    if score>=grp
        tempMap(good & isnan(tempMap))=score;
    end
    
    if i==1
        h=waitbar(0,'Generating season footprint');
    elseif mod(i,5000)==0
        waitbar(i/length(percOpts),h);
    end
end
delete(h);

climFoot=tempMap;
if plotYN==1
    figure()
    pcolor(flipud(Map));shading flat;
    freezeColors(gca);
    hold on;C=contour(flipud(climFoot),'k','Fill','off');shading('interp');
    clabel(C);
end