
clc;
clear all;
% Nuno Barreto; Diogo Matos; Hugo Matos
files = ["Hugo Matos_D1" ; "Diogo Matos_D1"];
ptests = 20;

disp("Checking files...");

totals = zeros(1,size(files,1));
for n=1:size(files,1)
    for m=1:size(files,2)
        [a,sheets]=xlsfinfo(files(n,m));
        totals(n) = totals(n) + length(sheets);
    end
end
total = min(totals);
Ynn = zeros(total,n);


tests = round(total * ptests /100);
train = total - tests;

disp("Extracting data...");
X=[]; Y=X; Xt=Y; Yt=Y; Ynn=zeros(train,size(files,1));
for n=1:size(files,1)
    c = strsplit(files(n,1),'_');
    fprintf("\t" + c(1) + " - " + total + "(" + train + "+" + tests + ")\n");
    remain = train;
    for m=1:size(files,2)
        [a,sheets]=xlsfinfo(files(n,m));
        for i=1:length(sheets) 
            if remain > 0
                X = [X xlsread(files(n,m),i,"P15:P23")];
                Y = [Y;(-1)^n];
                
                remain = remain - 1;
            end
            if remain == 0
                Xt = [Xt xlsread(files(n,m),i,"P15:P23")];
                Yt = [Yt;(-1)^n];
            end
        end
        
    end
end





disp("Sorting results");
X=X'; Xt=Xt';

disp("Clearing temporary variables");
clear files;
clear menor;
clear a;
clear i;
clear n;
clear m;
clear c;
clear ptests;
clear train;
clear remain;
clear tests;
clear total;
clear totals;
clear sheets;
clear tests;

disp("Saving results to file...");
save("NMM");

fprintf("\nAll Done!\n");
