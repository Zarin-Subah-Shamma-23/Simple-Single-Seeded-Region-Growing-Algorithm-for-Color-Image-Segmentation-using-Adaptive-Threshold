% Zarin Subah Shamma : A02368194
% Final Project

function [REGION, outlineIm] = improvedAlgorithm(im1)

    % If the image has only one channel, convert it into 3 channel image
    [~,~,p] = size(im1);
    if p == 1
        im = cat(3, im1, im1, im1);
    else
        im = im1; 
    end
    
    % Calling the new seed selection method
    seed = newSeedSelection(im);  
    
    % Using the propsed algorithm with the new seed
    [REGION] = RegionGrowingAlgo(im,seed);
    
    % Getting the outline/border of the segmented regions
    SE = strel('disk',2);
    outlineImD = imdilate(REGION,SE);
    outlineIm = outlineImD - REGION;

end

