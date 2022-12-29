% Zarin Subah Shamma : A02368194
% Final Project

function [R, Fscaled] = calculateFvalue(REGION,im,REGION1,scalingFactor)
    
    % Converting matrix to an array
    REGIONarr = REGION';
    REGIONarr = REGIONarr(:)';

    % Sorting the array
    REGIONarr = sort(REGIONarr);
    
    % Deleting the duplicate values 
    REGIONarrU = unique(REGIONarr);
    
    % Deleting the zero value 
    REGIONarrU(REGIONarrU==0) = [];

    R = numel(REGIONarrU);  % Number of Region 
    nIm = numel(REGION);
    [row,col] = size(REGION); 
    count = 0; 
    countAi = []; 

    % Calculating number of pixels in each region 
    for idx1 = 1:R
        for idx2 = 1:nIm
            if REGIONarrU(idx1) == REGION(idx2)
                count = count + 1; 
            end 
        end
        countAi(end+1) = count;  % Number of pixels in each region  
        count = 0;
    end

    euclid = [];
    row1 = 1;

    % Euclidean distance of intensities between original and segmented image of each pixel in each region 
    for idx = 1:R
        for i = 1:row
            for j = 1:col
                if REGIONarrU(idx) == REGION(i,j)
                    euclid(row1,idx) = sqrt((double(im(i,j,1)-REGION1(i,j,1))^2) + (double(im(i,j,2)-REGION1(i,j,2))^2) + (double(im(i,j,3)-REGION1(i,j,3))^2));
                    row1 = row1 + 1; 
                end
            end
        end
        row1 = 1; 
    end

    ei = [];
    c = size(euclid,2); 

    % Sum of euclidean distance of each region 
    for idx3 = 1:c
        ei(end+1) = sum(euclid(:,idx3));
    end

    % Multiplying ei and Ai 
    for idx4 = 1:R
        f1 = ((ei(idx4))^2)/(sqrt(countAi(idx4)));
    end

    % Calculating Liu's F-factor 
    F = sqrt(R) * f1; 

    % Normalization by the size of the image 
    Fnorm = F/numel(im); 
    
    % Scaling 
    Fscaled = Fnorm/scalingFactor; 

end

