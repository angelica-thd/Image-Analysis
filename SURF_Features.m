clc;
clear;

folder = 'training_img';
training_set = dir(fullfile(folder,'*.png'));
N = length(training_set);

arr = []
for i = 1:N
%Calculate superpixels of the image.
curr_file = fullfile(folder,training_set(i).name);
img = imread(curr_file);
%img = im2double(training_set(i));
[L,NumSuperpixels] = superpixels(img,50);
%Set the color of each pixel in the output image to the mean color of the superpixel region.
outputImage = zeros(size(img),'like',img);
idx = label2idx(L);
numRows = size(img,1);
numCols = size(img,2);
    for labelVal = 1:NumSuperpixels
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+numRows*numCols;
        blueIdx = idx{labelVal}+2*numRows*numCols;
        outputImage(redIdx) = mean(img(redIdx));
        outputImage(greenIdx) = mean(img(greenIdx));
        outputImage(blueIdx) = mean(img(blueIdx));
        surfImage = rgb2gray(outputImage);
        points = detectSURFFeatures(surfImage);
        [features,valid_points] = extractFeatures(surfImage,points);
        if valid_points.Count == 0
            featuresSurf = [0 0 0 0 0 0];
        else 
            featuresSurf(1) = mean(valid_points.Scale);
            featuresSurf(2) = mean(valid_points.SignOfLaplacian);
            featuresSurf(3) = mean(valid_points.Orientation);
            k = mean(valid_points.Location);
            featuresSurf(4) = k(1);
            if size(k) == 2
                featuresSurf(5) = k(2);
            else
                featuresSurf(5) = 0;
            end
            featuresSurf(6) = mean(valid_points.Metric);
        end    
        arr = cat(1,arr,featuresSurf);
    end 
end

