clc;

%define the matrix size

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

%Generate 4x4 WHT
Hadamard_4by4 = hadamard(Size);

%Order the WHT matrix
Hadamard_4by4_Ordered = zeros(Size,Size);
for i = 1:Size %Column
    counter = 0;
    temp = Hadamard_4by4(1,i);
    for j = 2:Size %Row
         if temp ~= Hadamard_4by4(j,i);
             counter = counter + 1;
             temp = Hadamard_4by4(j,i);
         end
    end
    for k = 1:Size
        Hadamard_4by4_Ordered(k,counter+1) = Hadamard_4by4(k,i);
    end
end

%Plot the hadamard basis functions
M = zeros(Size,Size);  % Preallocate matrix
for i = 1:Size
    for j = 1:Size
        M = Hadamard_4by4_Ordered(i,:)' * Hadamard_4by4_Ordered(j,:); %Row transposed * row
        M
        subplot(Size,Size,((i-1)*Size) + j), imshow(M);
    end
end

%Get WHT coefficients
Coef = Hadamard_4by4'*f_Offset_by_128*Hadamard_4by4;

%Multiple the coef with the basis matrices and sum the results
M_SUM = zeros(Size,Size);
for i = 1:Size
    for j = 1:Size
        M = Hadamard_4by4_Ordered(i,:)' * Hadamard_4by4_Ordered(j,:);
        M1 = Coef(i,j)*M;
        M_SUM = M_SUM+M1;
    end
end

%Output the 2 matrices to the console
M_SUM
f_Offset_by_128



