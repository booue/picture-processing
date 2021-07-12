function test
scale('image_3.jpg',[2160,3840])


function output_img = scale(input_img, scale_size) 
img = imread(input_img); %读取输入图片的数据
[h,w] = size(img(:,:,1)) %获取行和列，即原图的高度和宽度
 
scale_h = scale_size(1); %根据输入获得缩放后的新宽度
scale_w = scale_size(2); %根据输入获得缩放后的新高度
output_img = zeros(scale_h, scale_w,3); %初始化
for m = 1:3
    for i = 1 : scale_h         %缩放后的图像的（i,j）位置对应原图的（x,y）
        for j = 1 : scale_w
            x = i * h / scale_h;
            y = j * w / scale_w;
            u = x - floor(x);
            v = y - floor(y); %取小数部分
        
            if x < 1           %边界处理
                x = 1;
            end
        
            if y < 1
                y = 1;
            end
        
 
        %用原图的四个真实像素点来双线性插值获得“虚”像素的像素值
            output_img(i, j,m) = img(floor(x), floor(y),m) * (1-u) * (1-v) + ...
                                   img(floor(x), ceil(y),m) * (1-u) * v + ...
                                   img(ceil(x), floor(y),m) * u * (1-v) + ...
                                   img(ceil(x), ceil(y),m) * u * v;
        end
    end
end
 


imwrite(uint8(output_img), '../output_img.png'); %保存处理后的图像
imshow(input_img); %显示原图
title('原彩色图像')
figure,imshow(uint8(output_img)) %显示处理后的图像
title('插值法压缩图像')
figure,imshow(imresize(img,2))
title('函数法压缩图像')