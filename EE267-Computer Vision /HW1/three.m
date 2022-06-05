clc;
close all;
clear all;

I = [52 55 61 66 70 61 64 73;        %The Image
    63 59 66 90 109 85 69 72;
    62 59 68 113 144 104 66 73;
    63 58 71 122 154 106 70 69;
    67 61 68 104 126 88 68 70;
    79 65 60 70 77 68 589 75;
    85 71 64 59 55 61 65 83;
    87 79 69 68 65 76 78 94];

C = [60 65 70 75;
    60 70 80 90;
    65 75 85 95;
    60 80 100 120]; %The initial Codebook

w = [];
c1 = [];c2 = [];c3 = [];c4 = [];
[xI, yI] = size (I);       %Size of image
[xC, yC] = size(C);      %Size of Codebook
error1 = [];
errorlog=[];
error = 263833; %error was computed manually
epsilon=12397;
errorlog = [error+1];
a = 1;

% trying to reach a convergence by minimizing the average distortion. 
%this is done by moving the codevectors step by step to the center of the
%points.
while errorlog(a) > epsilon;
    f = 0;
    a =a +1;
    error = 0;
    %find closest codevectors for each vector in data
    for i = 1:2:xI-1
        for k = 1:2:yI-1
            A = [I(i,k) I(i,k+1) I(i+1,k) I(i+1, k+1)];
            for o = 1:1:xC
                B = 0;
                for p =1:1:yC
                    m = C(o,p) - A(1,p);
                    B = B + m.^2;  
                end
                w = [w B];
            end
            [v u] = min(w);
            f = [f u];
            w = [];
            error = v + error;    %updating error
            if u == 1
                c1 = [c1;A];
            elseif u == 2
                c2 = [c2;A];
            elseif u == 3
                c3 = [c3;A];
            elseif u == 4
                c4 = [c4;A];   
            end
        end

    end
    error;
    errorlog = [errorlog error];
    error1 = [error1 error];
    %code1 
    [x1 y1] = size(c1);
    c1sum = sum(c1,1);
    for k = 1:4
        C(1,k) = floor(c1sum(1,k)/x1);
    end
    %code2
    [x1 y1] = size(c2);
    c1sum = sum(c2,1);
    for k = 1:4
        C(2,k) = floor(c1sum(1,k)/x1);
    end
    %code3
    [x1 y1] = size(c3);
    c1sum = sum(c3,1);
    for k = 1:4
        C(3,k) = floor(c1sum(1,k)/x1);
    end


    [x1 y1] = size(c4);
    c1sum = sum(c4,1);
    for k = 1:4
        C(4,k) = floor(c1sum(1,k)/x1);
    end

end
f(1)=[];
f = reshape(f,[4 4])';
[x y] = size(errorlog);

disp('The new representation is:');
disp(f-1)
disp('The updated Codebook is:');
disp(C)












