% Zarin Subah Shamma : A02368194
% Final Project

function [segmentedImW] = watershedAlgo(im)

    % Watershed Segmentation using MATLAB built-in function with 8-neighborhood connectivity
    segmentedImW = watershed(im,8);

end

