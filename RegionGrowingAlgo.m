% Zarin Subah Shamma : A02368194
% Final Project

function [REGION] = RegionGrowingAlgo(im,seed)

    [R, C, ~] = size(im);
    % Counter to keep track of region
    Rcount = 1; 

    % Stack to store boundary pixels
    BP = []; 
    
    % Stack to store pixels to grow
    PG = seed; 
    
    % Current pixel
    CP = [];
    
    % 8 neighbors of CP
    CP8 = []; 
    
    % Matrix with same size of image storing the labels
    REGION = zeros(R,C);

    % Taking the three channels of image
    Rim = im2double(im(:,:,1));
    Gim = im2double(im(:,:,2));
    Bim = im2double(im(:,:,3));

    % Threshold using Otsu's method
    thr = graythresh(im); 


    %% Step 1

    while ~isempty(PG) 

        % The first value of PG is in CP now
        CP = PG(1,:);
        
        % The first value of PG is removed
        PG(1,:) = []; 

        % When the value of CP is not 481,321 & 1, calculate the 8-neighbors
        if CP(end,1)<R && CP(end,2)<C && CP(end,1)>1 && CP(end,2)>1
            CP8(1,:) = [CP(end,1)-1,CP(end,2)-1]; 
            CP8(2,:) = [CP(end,1)-1,CP(end,2)]; 
            CP8(3,:) = [CP(end,1)-1,CP(end,2)+1];
            CP8(4,:) = [CP(end,1),CP(end,2)-1];
            CP8(5,:) = [CP(end,1),CP(end,2)+1];
            CP8(6,:) = [CP(end,1)+1,CP(end,2)-1];
            CP8(7,:) = [CP(end,1)+1,CP(end,2)];
            CP8(8,:) = [CP(end,1)+1,CP(end,2)+1];
        end

        for k=1:8
            if REGION(CP8(k,1),CP8(k,2)) == 0   % If the pixel is not labeled
                
                % Calculating the intensity based similarity index between seed and the 8-neighbors
                Dr = (abs(Rim(CP8(k,1),CP8(k,2))-Rim(seed(1,1),seed(1,2)))).^2;
                Dg = (abs(Gim(CP8(k,1),CP8(k,2))-Gim(seed(1,1),seed(1,2)))).^2;
                Db = (abs(Bim(CP8(k,1),CP8(k,2))-Bim(seed(1,1),seed(1,2)))).^2;

                DIST = sqrt(Dr + Dg + Db);

                if DIST < thr
                    
                    % Labelling the region that has lower distance value than threshold
                    REGION(CP8(k,1),CP8(k,2)) = Rcount;
                    
                    % Taking the next region to grow
                    PG(end+1,:) = [CP8(k,1),CP8(k,2)];
                else
                    
                    % While the DIST>thr, the pixel will be a boundary pixel
                    BP(end+1,:) = [CP8(k,1),CP8(k,2)];
                end
            end
        end   
    end

    %% Step 2

    while ~isempty(BP)

        % Boundary pixel will be the seed 
        seed(1,:) = BP(end,:);
        
        % The first value of BP is removed
        BP(1,:) = [];

        % Rcount will be increased if the seed pixel is not labled 
        if REGION(seed(1,1),seed(1,2)) == 0
            Rcount = Rcount+1; 
        end

        % Store the seed value to PG
        PG(1,:) = [seed(1,1),seed(1,2)];

        % Step 1 

        while ~isempty(PG) 

            CP = PG(1,:);
            PG(1,:) = []; 

            if CP(end,1)<R && CP(end,2)<C && CP(end,1)>1 && CP(end,2)>1
                CP8(1,:) = [CP(end,1)-1,CP(end,2)-1]; 
                CP8(2,:) = [CP(end,1)-1,CP(end,2)]; 
                CP8(3,:) = [CP(end,1)-1,CP(end,2)+1];
                CP8(4,:) = [CP(end,1),CP(end,2)-1];
                CP8(5,:) = [CP(end,1),CP(end,2)+1];
                CP8(6,:) = [CP(end,1)+1,CP(end,2)-1];
                CP8(7,:) = [CP(end,1)+1,CP(end,2)];
                CP8(8,:) = [CP(end,1)+1,CP(end,2)+1];
            end

            for k=1:8
                if REGION(CP8(k,1),CP8(k,2)) == 0
                    Dr = (abs(Rim(CP8(k,1),CP8(k,2))-Rim(seed(1,1),seed(1,2)))).^2;
                    Dg = (abs(Gim(CP8(k,1),CP8(k,2))-Gim(seed(1,1),seed(1,2)))).^2;
                    Db = (abs(Bim(CP8(k,1),CP8(k,2))-Bim(seed(1,1),seed(1,2)))).^2;

                    DIST = sqrt(Dr + Dg + Db);

                    if DIST < thr
                        REGION(CP8(k,1),CP8(k,2)) = Rcount; 
                        PG(end+1,:) = [CP8(k,1),CP8(k,2)];
                    else
                        BP(end+1,:) = [CP8(k,1),CP8(k,2)];
                    end
                end
            end   
        end
    end
     

end




