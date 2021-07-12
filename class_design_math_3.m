function test
scale('image_3.jpg',[2160,3840])


function output_img = scale(input_img, scale_size) 
img = imread(input_img); %��ȡ����ͼƬ������
[h,w] = size(img(:,:,1)) %��ȡ�к��У���ԭͼ�ĸ߶ȺͿ��
 
scale_h = scale_size(1); %�������������ź���¿��
scale_w = scale_size(2); %�������������ź���¸߶�
output_img = zeros(scale_h, scale_w,3); %��ʼ��
for m = 1:3
    for i = 1 : scale_h         %���ź��ͼ��ģ�i,j��λ�ö�Ӧԭͼ�ģ�x,y��
        for j = 1 : scale_w
            x = i * h / scale_h;
            y = j * w / scale_w;
            u = x - floor(x);
            v = y - floor(y); %ȡС������
        
            if x < 1           %�߽紦��
                x = 1;
            end
        
            if y < 1
                y = 1;
            end
        
 
        %��ԭͼ���ĸ���ʵ���ص���˫���Բ�ֵ��á��顱���ص�����ֵ
            output_img(i, j,m) = img(floor(x), floor(y),m) * (1-u) * (1-v) + ...
                                   img(floor(x), ceil(y),m) * (1-u) * v + ...
                                   img(ceil(x), floor(y),m) * u * (1-v) + ...
                                   img(ceil(x), ceil(y),m) * u * v;
        end
    end
end
 


imwrite(uint8(output_img), '../output_img.png'); %���洦����ͼ��
imshow(input_img); %��ʾԭͼ
title('ԭ��ɫͼ��')
figure,imshow(uint8(output_img)) %��ʾ������ͼ��
title('��ֵ��ѹ��ͼ��')
figure,imshow(imresize(img,2))
title('������ѹ��ͼ��')