% 灰度图像处理

function test
scale('image_1.png',[512,768])



function output_img = scale(input_img,scale_size)


A = imread(input_img);
img = A(:,:,3);
[h,w] = size(img);
% h = 256 w = 384


scale_h = scale_size(1);
scale_w = scale_size(2);
output_img = zeros(scale_h,scale_w);


for i = 1:scale_h
    for j = 1:scale_w
        x = i.*h / scale_h; %x:高度
        y = j.*w / scale_w; %y:宽度
        u = x - floor(x);
        v = y - floor(y);
        
        if x < 1
            x = 1;
        end
        
        if y < 1
            y = 1;
        end
        
        output_img(i,j) = v.*(u.*img(ceil(x),ceil(y)) + (1 - u).*img(floor(x),ceil(y))) + ...
                          (1 - v).*(u.*(img(ceil(x),floor(y))) + (1-u).*img(floor(x),floor(y)));
    end
end

% imwrite(uint8(output_img),'../output_img.png');
imshow(input_img)
title('原灰度图像')
figure,imshow(uint8(output_img))
title('插值法压缩图像')
figure,imshow(imresize(img,2))
title('函数法压缩图像')