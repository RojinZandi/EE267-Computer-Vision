clc;

Size = 4;

f=[1 0 1 0;
    2 0 2 0;
    0 1 0 1;
    -1 0 -1 0];

%offset by 128 (Subtract each item by 128)
f_Offset_by_128 = zeros(Size, Size);
for i = 1:Size
    for j = 1:Size
        f_Offset_by_128(i,j) = f(i,j) - 128;
    end
end

DCT_4by4 = dctmtx(Size);

M = zeros(Size,Size);  % Preallocate matrix
for i = 1:Size
    for j = 1:Size
        M = DCT_4by4(i,:)' * DCT_4by4(j,:);
        M
        subplot(Size,Size,((i-1)*Size) + j);
        imshow(M);
        
    end
end

%Get DCT coefficients
Coef = DCT_4by4'*f_Offset_by_128*DCT_4by4

%Multiple the coef with the basis matrices and sum the results
M_SUM = zeros(Size,Size);
for i = 1:Size
    for j = 1:Size
        M = DCT_4by4(:,i)* DCT_4by4(:,j)';
        M1 = Coef(i,j)*M;
        M_SUM = M_SUM+M1;
    end
end
%Output the 2 matrices to the console
M_SUM
f_Offset_by_128



