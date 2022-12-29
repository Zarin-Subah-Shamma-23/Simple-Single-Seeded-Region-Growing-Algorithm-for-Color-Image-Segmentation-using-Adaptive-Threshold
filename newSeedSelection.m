% Zarin Subah Shamma : A02368194
% Final Project 

function [seed] = newSeedSelection(im1)

    % Converting the image into Grayscale
    imBW = rgb2gray(im1);
    [R, C] = size(imBW);
    divR = [];
    divC = [];
    seed = [];

    % Dividing the Rows into 3 bins
    intervalR = round(R/3);
    for idx = 1:intervalR:R
        divR(end+1) = idx;
    end
    divR(end+1) = R;

    % Dividing the Columns into 3 bins
    intervalC = round(C/3);
    for idx = 1:intervalC:C-1
        divC(end+1) = idx;
    end
    divC(end+1) = C;

    sumR = [];
    sumC = []; 
    temp = [];

    % Sum of each Bin of Rows
    for idx = 1:numel(divR)-1
        x = divR(idx);
        y = divR(idx+1);
        temp = imBW(x:y,:);
        sumR(end+1) = sum(temp,'all');
        temp = [];
    end

    % Sum of each Bin of Columns
    temp = [];
    for idx = 1:numel(divC)-1
        x = divC(idx);
        y = divC(idx+1);
        temp = imBW(:,x:y);
        sumC(end+1) = sum(temp,'all');
        temp = [];
    end

    % Taking the Maximum Sum among 3 Bins of Rows
    sumR(sumR<max(sumR)) = 0;
    
    % Taking the Maximum Sum among 3 Bins of Columns
    sumC(sumC<max(sumC)) = 0;

    % Extracting the selected Bin number of Rows and Columns
    for idx=1:numel(sumC)
        if sumR(idx)>0
            idR = idx;
        end
        if sumC(idx)>0
            idC = idx;
        end
    end

    % New Seed = Middle Pixel of the region containing Maximum Sum (Row & Column)
    R1 = round((divR(idR+1) - divR(idR))/2);
    C1 = round((divC(idC+1) - divC(idC))/2);
    seed(1,:) = [R1,C1];

end

