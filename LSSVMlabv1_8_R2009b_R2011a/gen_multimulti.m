
clc;
clear all; close all;
%% DEFINES
% Nuno Barreto; Diogo Matos; Hugo Matos; Hugo Santos; Mario Filipe; Luis
% Bonito
%players
selections = [1 2 4 6];
%distance
putts=1;
%percentage of samples used as tests
ptests = [35];
%max putts per distance, select 0 for max available
max=0;
%number of repetions per ratio for averaging
reps=1;

%% Create DUMP matrix with all the putts contained in all sheets available on a n,m 
%  matrix of file
%
% Nuno Barreto; Diogo Matos; Hugo Matos; Hugo Santos; Mario Filipe; Luis
% Bonito
files = ["Nuno Barreto_D1" "Nuno Barreto_D2" "Nuno Barreto_D3" "Nuno Barreto_D4"; ...
         "Diogo Matos_D1" "Diogo Matos_D2" "Diogo Matos_D3" "Diogo Matos_D4"; ...
         "Hugo Matos_D1" "Hugo Matos_D2" "Hugo Matos_D3" "Hugo Matos_D4"; ...
         "Hugo Santos_D1" "Hugo Santos_D2" "Hugo Santos_D3" "Hugo Santos_D4"; ...
         "Mario Filipe_D1" "Mario Filipe_D2" "Mario Filipe_D3" "Mario Filipe_D4"; ...
         "Luis Bonito_D1" "Luis Bonito_D2" "Luis Bonito_D3" "Luis Bonito_D4";
         ];
%checks if there is already a dump file     
if exist("DUMP.mat","file") == 2
    disp("File found, loading...");
    load("DUMP");
    fprintf("DONE!\n");
else
    disp("This is a very slow process, please be patient.");     
    %checks if there is already a variable named 'dump'     
    if exist("DUMP",'var') == 0
        disp("DUMPING files:");
        DUMP = [];
        for n=1:size(files,1)
            c = strsplit(files(n,1),'_');
            fprintf("\t" + c(1) + "\n");
            for m=1:size(files,2)
                fprintf("\t\t file " + m + " ");        
                [a,sheets]=xlsfinfo(files(n,m));
                for i=1:length(sheets) 
                    fprintf(".");        
                    DUMP = [DUMP [n; m; xlsread(files(n,m),i,"P15:P23")]];
                end
                fprintf(" (" + i + " sheets)\n");
            end
        end
        disp("DUMPING complete");
        varcl = {'DUMP', 'files', 'selections', 'puts', 'ptests', 'max'};
        clearvars('-except',varcl{:});
        DUMP = DUMP';
        save("DUMP")
    else
        disp("Variable DUMP already exists, delete it if you want to repeat process!");
    end
end
fprintf("DONE!\n");


%% retrieves 'putts' putts from 'selection' players

fprintf("Filtering selections...");
C = [];
for i=1:length(selections);
    C = [C; DUMP(DUMP(:,1)==selections(i) & DUMP(:,2)==putts,:)];
end
fprintf("DONE!\n");

%% Gets the min number of putts on all selections
fprintf("Getting max common putts...");
[D,ia,ic] = unique(C(:,1),'rows');
total = min(histc(C(:,1),D));
if max~=0 total = max; end
fprintf("DONE!\n");


PPV = []; TPR = []; ACC = [];
%% Iterates over different train vs test ratio
for pt=1:length(ptests)
    fprintf("\n\n------------------------------------------------------------------\n");
    fprintf("Testing a " + (100-ptests(pt)) + "/" + ptests(pt) + " ratio\n");
    fprintf("------------------------------------------------------------------\n");
    tmpp = []; tmpr = []; tmpa = [];
    for rep=1:reps
        %% Defines train vs test ratio
        tests = round(total * ptests(pt) /100);
        train = total - tests;

        fprintf(ptests(pt) + " - REP " + rep + " - Extracting data...\n");
        X=[]; Y=X; Xt=Y; Yt=Y; Xnn=X; Ynn=X;
        
        %% Iterates over different selections to generate X,Y,Xt,Yt (Xnn, Ynn)
        for n=1:length(selections)
            c = strsplit(files(n,1),'_');
            fprintf("\t" + c(1) + " - " + total + "(" + train + "+" + tests + ")\n");
            % gets puts for this selection
            E = C(C(:,1)==selections(n),:);
            % splits them into training and test putts
            X = [X; E(1:train,:)];
            Xt = [Xt; E(train+1:total,:)];
            % generates NN matrixes
            Xnn = [Xnn; E(1:total,:)];
            if n==1 j=1;
            else j=(n-1)*total+1; end
            Ynn(j:n*total,n)=1;
        end
        % uses players IDs as classficator
        Y = X(:,1);
        Yt = Xt(:,1);
        % removes player and distance IDs
        X = X(:,3:11);
        Xt = Xt(:,3:11);
        Xnn = Xnn(:,3:11);
        fprintf("DONE!\n");

        fprintf("Saving data to file...");
        save("SVM_NN");
        fprintf("DONE!\n");
        
        fprintf("\nTesting...\n");
        if length(selections)>2 
            [acc,prc,rcl] = test_multiclass();
        else [acc,prc,rcl] = test_uniclass(); end
        if prc == 0 prc=nan; end
        if rcl == 0 rcl=nan; end
        if acc == 0 acc=nan; end
        tmpp = [tmpp prc]; tmpr = [tmpr rcl]; tmpa = [tmpa acc];
        fprintf(1,'Accuracy: %2.2f\n',rcl);
        fprintf(1,'Precision: %2.2f\n',prc);
        fprintf(1,'Sensitivity: %2.2f\n',rcl);
        fprintf("------------------------------------------------------------------\n");
    end
    PPV = [PPV; [ptests(pt) tmpp]]; TPR = [TPR; [ptests(pt) tmpr]]; ACC = [ACC; [ptests(pt) tmpa]];
end
%% Process metrics
%extracts values for averaging
tmpp2 = PPV(:,2:rep+1); tmpr2 = TPR(:,2:rep+1); tmpa2 = ACC(:,2:rep+1);    
%averages the results of all repetitions
PPV=[PPV nanmean(tmpp2,2)]; TPR=[TPR nanmean(tmpr2,2)]; ACC=[ACC nanmean(tmpa2,2)];
%removes unnecessary data
PPV=PPV(:,[1 reps+2]); TPR=TPR(:,[1 reps+2]); ACC=ACC(:,[1 reps+2]);
%tranposition for easier reading
PPV=PPV'; TPR=TPR'; ACC=ACC';
%adds ratio labels
ALLMETRICS = ACC(1,:);
%adds results
ALLMETRICS = [ALLMETRICS; ACC(2,:);PPV(2,:);TPR(2,:)];
%adds metrics labels
labels = ["RATIO";"ACCURACY";"PRECISION";"SENSITIVITY"];
ALLMETRICS = [labels ALLMETRICS];
    
    
%% Saves relevant data
% clears unnecessary data
fprintf("Clearing temporary variables...");
varcl = {'X', 'Y', 'Xt', 'Yt', 'Xnn', 'Ynn', 'DUMP', 'ALLMETRICS' };
clearvars('-except',varcl{:});
fprintf("DONE!\n"); 

fprintf("Saving data to file...");
save("SVM_NN");
fprintf("DONE!\n");
beep