function [clusters,centers] = color_discretization(folder)

[rgb_set,lab_set] = rgb2lab_trainset(folder);
N = length(lab_set);
ab = cell(1,N);

for i = 1:N  
    ab = lab_set{i};
    ab = im2single(ab);     %convert image to single to use imsegkmeans
    k = 15;
    
    [pixel_labels, center] = imsegkmeans(ab,k,'NumAttempts',3);
    
    centers{i} = center;
    
    figure(1);
    subplot(2,3,1)
    imshow(rgb_set{i});
    caption = sprintf('Original Image. Image %d of %d.',i,N);
    title(caption,'FontSize',10); 
    drawnow;   
    
    subplot(2,3,2)
    imshow(lab_set{i});
    caption = sprintf('Lab Image. Image %d of %d.',i,N);
    title(caption,'FontSize',10); 
    drawnow;  
    
    [labels,c] =imsegkmeans(rgb_set{i},k);
    quant_img{i} = label2rgb(labels,im2double(c));
    caption = sprintf('Color quantized Image. Image %d of %d.',i,N);
  	subplot(2,3,3);
    imshow(quant_img{i});
    title(caption,'FontSize',10); 
    drawnow;   
    
    %displays the color segmentation on the image
%     subplot(1,3,3)
%     imshow(pixel_labels,[]);
%     caption = sprintf('Image Labeled by Cluster Index. Image %d of %d.',i,N);
%     title(caption,'FontSize',10); 
%     drawnow;   
    
    for j = 1:k;
        mask{j} = pixel_labels == j;
        clusters{j} = rgb_set{i} .* uint8(mask{j});
        lab_clusters{j} = lab_set{i} .* mask{j};
    end 
   
   subplot(2,3,[4 5 6]);
   caption = sprintf('Centers. Image %d of %d.',i,N);
   gscatter(centers{1,i}(:,2,:),centers{1,i}(:,3,:),centers{i});
   title(caption,'FontSize',10);
   drawnow;
      
    
end
end