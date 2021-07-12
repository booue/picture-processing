% �Ҷ�ͼ����

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
        x = i.*h / scale_h; %x:�߶�
        y = j.*w / scale_w; %y:���
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
title('ԭ�Ҷ�ͼ��')
figure,imshow(uint8(output_img))
title('��ֵ��ѹ��ͼ��')
figure,imshow(imresize(img,2))
title('������ѹ��ͼ��')