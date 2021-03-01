function [train_lab_set] = rgb2lab_trainset(training_set_path)

%folder = 'training_img';

training_set = dir(fullfile(training_set_path,'*.jpg'));
N = length(training_set);
train_lab_set = cell(1,N);

for i = 1:N
    curr_file = fullfile(training_set_path,training_set(i).name);
    curr_img = imread(curr_file);
    
    figure(1);
    %show original rgb reference image
    subplot(3,3,1);
    imshow(curr_img);
    caption = sprintf('Original image. Image %d of %d.',i,N);
    title(caption,'FontSize',10); 
    drawnow;
    
    %show Lab reference image
    lab = rgb2lab(curr_img);
    train_lab_set{i} = lab;
    mx = 0;
    for c = 1:3
        if mx < max(max(lab(:,:,c))) 
            mx = max(max(lab(:,:,c)));
        end
    end
    mn = mx;
    for c = 1:3
        if mn > min(min(lab(:,:,c))) 
            mn = min(min(lab(:,:,c)));
        end
    end

    subplot(3,3,3);
    imshow(lab);
     caption = sprintf('Lab image. Image %d of %d.',i,N);
    title(caption,'FontSize',10);
    drawnow;


    %compute histogram of RGB image
    ref_R = curr_img(:,:,1);
    ref_G = curr_img(:,:,2);
    ref_B = curr_img(:,:,3);


    subplot(3,3,4);
    histogram(ref_R,'BinWidth',5,'LineWidth',0.1,'EdgeColor','w','FaceColor','r');
    title('Histogram of R channel', 'FontSize', 10);
    xlabel('Red', 'FontSize', 10);
    xlim([0 255]);
    ylabel('Pixel Count', 'FontSize', 10);
    ylim auto

    subplot(3,3,5);
    histogram(ref_G,'BinWidth',5,'LineWidth',0.1,'EdgeColor','w','FaceColor','g');

    title('Histogram of Green channel', 'FontSize', 10);
    xlabel('Green', 'FontSize', 10);
    xlim([0 255]);
    ylabel('Pixel Count', 'FontSize', 10);
    ylim auto


    subplot(3,3,6);
    histogram(ref_B,'BinWidth',5,'LineWidth',0.1,'EdgeColor','w','FaceColor','b');
    title('Histogram of Blue channel', 'FontSize', 10);
    xlabel('Blue', 'FontSize', 10);
    xlim([0 255]);
    ylabel('Pixel Count', 'FontSize', 10);
    ylim auto

    %show histogram of Lab image
    lab_L = lab(:,:,1);
    lab_a = lab(:,:,2);
    lab_b = lab(:,:,3);


    subplot(3,3,7);
    histogram(lab_L,'BinWidth',5,'LineWidth',0.1,'EdgeColor','w');
    title('Histogram of L channel', 'FontSize', 10);
    xlabel('L value', 'FontSize', 10);
    ylabel('Pixel Count', 'FontSize', 10);
    xlim ([mn mx])
    ylim auto



    subplot(3,3,8);
    histogram(lab_a,'BinWidth',5,'LineWidth',0.1,'EdgeColor','w','FaceColor','m');
    title('Histogram of A channel', 'FontSize', 10);
    xlabel('A value', 'FontSize', 10);
    ylabel('Pixel Count', 'FontSize', 10);
    xlim ([mn mx])
    ylim auto


    subplot(3,3,9);
    histogram(lab_b,'BinWidth',5,'LineWidth',0.1,'EdgeColor','w','FaceColor','y');
    title('Histogram of B channel', 'FontSize', 10);
    xlabel('B value', 'FontSize', 10);
    ylabel('Pixel Count', 'FontSize', 10);
    xlim ([mn mx])
    ylim auto
end
end

