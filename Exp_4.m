function customJPEGCompression
    clc; close all; clear all;

    % Read and display the original image
    I = imread('Eagle.png');
    subplot(1, 2, 1); imshow(I); title('Original Image');

    % Define the quantization matrix
    Q = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121  120 101;
     72 92 95 98 112 100 103 99];

    % Convert RGB to YCbCr
    Y = 0.299 * double(I(:,:,1)) + 0.587 * double(I(:,:,2)) + 0.114 * double(I(:,:,3));
    Cb = -0.1687 * double(I(:,:,1)) - 0.3313 * double(I(:,:,2)) + 0.5 * double(I(:,:,3)) + 128;
    Cr = 0.5 * double(I(:,:,1)) - 0.4187 * double(I(:,:,2)) - 0.0813 * double(I(:,:,3)) + 128;
    % Process each 8x8 block
    [rows, cols] = size(Y);
    Y_id = zeros(size(Y));
    for i = 1:8:rows
        for j = 1:8:cols
            if (i+7 <= rows) && (j+7 <= cols)
                block = Y(i:i+7, j:j+7);
                DCTBlock = customDCT(block);
                QuantizedBlock = round(DCTBlock ./ Q);
                DeQuantizedBlock = QuantizedBlock .* Q;
                Y_id(i:i+7, j:j+7) = customIDCT(DeQuantizedBlock);
            end
        end
    end
    % Convert YCbCr back to RGB
    R = Y_id + 1.402 * (Cr - 128);
    G = Y_id - 0.344136 * (Cb - 128) - 0.714136 * (Cr - 128);
    B = Y_id + 1.772 * (Cb - 128);
    CompImg = cat(3, uint8(R), uint8(G), uint8(B));

    subplot(1, 2, 2); imshow(CompImg); title('Compressed Image');
    % Save the image
    outputPath = 'E:\Huawei\Doccuments\4th Year 2nd semester\EEE 4218 Sessional Based on EEE 4217\Exp\CompImg.jpg';
    try
        imwrite(CompImg, outputPath, 'jpg');
        disp(['Image successfully saved to ', outputPath]);
    catch exception
        disp('Error saving the image:');
        disp(exception.message);
    end
end

function C = customDCT(P)
    C = zeros(8, 8);
    for i = 0:7
        for j = 0:7
            sum = 0;
            for x = 0:7
                for y = 0:7
                    sum = sum + P(x+1, y+1) * cos((2*x+1)*i*pi/16) * cos((2*y+1)*j*pi/16);
                end
            end
            alphai = 1; if i == 0, alphai = 1 / sqrt(2); end
            alphaj = 1; if j == 0, alphaj = 1 / sqrt(2); end
            C(i+1, j+1) = 0.25 * alphai * alphaj * sum;
        end
    end
end

function P = customIDCT(C)
    P = zeros(8, 8);
    for x = 0:7
        for y = 0:7
            sum = 0;
            for i = 0:7
                for j = 0:7
                    alphai = 1; if i == 0, alphai = 1 / sqrt(2); end
                    alphaj = 1; if j == 0, alphaj = 1 / sqrt(2); end
                    sum = sum + alphai * alphaj * C(i+1, j+1) * cos((2*x+1)*i*pi/16) * cos((2*y+1)*j*pi/16);
                end
            end
            P(x+1, y+1) = 0.25 * sum;
        end
    end
end
