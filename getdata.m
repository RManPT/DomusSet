clc;
close all;
% clear all;
%% DEFINES


%% Create DUMP matrix with all the putts contained in all sheets available on a n,m 

user_p = ["Global comfort" "FFFE9B2CA3BC"; ...
          "Thermal comfort" "FFFE53638989"; ...
          "Lighting comfort" "FFFEA8DB4B5C"; ...
          "Air quality" "FFFE645AA539"; ...
          "Acoustic comfort" "FFFE47C76887"];
%   119
user_f = ["Temperature" "FFFEAA6CD509"; ...
          "Humidity" "FFFE9249ADAB"; ...
          "Luminosity" "FFFE9A88BBDE"; ...
          "Ventilation / air speed" "FFFEBC2B3C4B"; ...
          "Smell" "FFFE8D49BB6C"; ...
          "Noise level" "FFFE7FADA15E"; ...
          "Agreeableness of background noise" "FFFE5B8669EB"];
% 138
rerun=1;
directory = 'Dataset\*\*.csv';  
a=rdir(directory,'bytes>0'); 
af=[];
%all files on dataset
for i=1:size(a,1)
  af = [af; string(a(i).name)];
end
      
%checks if there is already a dump file     
if exist("domusdata.mat","file") == 2
    rerun=0;
    disp("File found, loading...");
    load("domusdata");
    if ~isequal(af,allfiles) 
        rerun=1; 
        fprintf("WARNING New dataset detected!\n");
    end;
end

if rerun
    disp("This is a very slow process, please be patient.");    
    %checks if there is already a variable     
end
    if exist("User_perceptions",'var') == 0
        fprintf("\nExtracting User Perceptions!");
        dump=[];
        %creates stuctures to hold User Perceptions
        fields = matlab.lang.makeValidName(user_p(:,1));
        for i=1:size(user_p,1)
            dump.(convertStringsToChars(fields(i)))=[];
        end

        for i=1:size(user_p,1)
            txt = txtpadding(user_p(i,1)," ",55);
            fprintf("\n\t" + txt + " ");
            % filter User Perception files
            row_idx = (contains(af(:, end), lower(user_p(i,2)) ));
            b=af(row_idx,:);
            % gets data from each file
            s=size(b,1);
             for j=1:s
                statusdot(j,s); 
                set=strsplit(b(j),'\');
                set = str2num(convertStringsToChars(set(2)));        
                z =readtable(b(j), 'FileType', 'text', 'Delimiter', ';', 'ReadVariableNames', 0 , 'ReadRowNames', 0,'Format','%s%s');
                x = ones(size(z,1),1).*set;
%                 d = sscanf(sprintf('%s*', z{:}), '%f*');
                % add column with the experience number
                z = [array2table(x) z];
                dump.(convertStringsToChars(fields(i))) = [dump.(convertStringsToChars(fields(i))); z];
             end
            
            dump.(convertStringsToChars(fields(i))) = sortrows(dump.(convertStringsToChars(fields(i))),'Var1','ascend');
            dump.(convertStringsToChars(fields(i))).Var1 = cellfun(@convertCharsToStrings, dump.(convertStringsToChars(fields(i))).Var1);
            dump.(convertStringsToChars(fields(i))).Var2 = cellfun(@convertCharsToStrings, dump.(convertStringsToChars(fields(i))).Var2);
        end
        User_perceptions = dump;
     end
    
    %checks if there is already a variable     
    if exist("User_feelings",'var') == 0
        fprintf("\nExtracting User Feelings!");
        dump=[];
        %creates stuctures to hold User Perceptions
        fields = matlab.lang.makeValidName(user_f(:,1));
        for i=1:size(user_f,1)
            dump.(convertStringsToChars(fields(i)))=[];
        end
        for i=1:size(user_f,1)
            txt = txtpadding(user_f(i,1)," ",55);
            fprintf("\n\t" + txt + " ");
            % filter User Perception files
            row_idx = (contains(af(:, end), lower(user_f(i,2)) ));
            b=af(row_idx,:);
             s=size(b,1);
            % gets data from each file
             for j=1:s
                statusdot(j,s);    
                set=strsplit(b(j),'\');
                set = str2num(convertStringsToChars(set(2)));    
                z = [];
                z =readtable(b(j), 'FileType', 'text', 'Delimiter', ';', 'ReadVariableNames', 0 , 'ReadRowNames', 0,'Format','%s%s');
                x = ones(size(z,1),1).*set;
                % add column with the experience number
                z = [array2table(x) z];
                dump.(convertStringsToChars(fields(i))) = [dump.(convertStringsToChars(fields(i))); z];
             end
            dump.(convertStringsToChars(fields(i))) = sortrows(dump.(convertStringsToChars(fields(i))),'Var1','ascend');
            dump.(convertStringsToChars(fields(i))).Var1 = cellfun(@convertCharsToStrings, dump.(convertStringsToChars(fields(i))).Var1);
            dump.(convertStringsToChars(fields(i))).Var2 = cellfun(@convertCharsToStrings, dump.(convertStringsToChars(fields(i))).Var2);
        end
        User_feelings = dump;
        
    end
    
% gets only sensor files
b=af;
for i=1:size(user_p,1)
            row_idx = (~contains(b(:, end), lower(user_p(i,2)) ));
            b=b(row_idx,:);            
end
for i=1:size(user_f,1)
            row_idx = (~contains(b(:, end), lower(user_f(i,2)) ));
            b=b(row_idx,:);
end
sensorfiles=b;
errors=[];
% clear Sensors_data;    
    if exist("Sensors_data",'var') == 0
%         fprintf("\nExtracting Sensors Data!");
        s=size(sensorfiles,1);
            txt = txtpadding("Extracting Sensors Data!"," ",58);
            fprintf("\n" + txt);
            dump=[];
             for j=1:s
                statusdot(j,s);   
                 set=strsplit(sensorfiles(j),'\');
                sensor=extractBefore(set(3),13);
                set = str2num(convertStringsToChars(set(2)));     
                z =readtable(sensorfiles(j), 'FileType', 'text', 'Delimiter', ';', 'ReadVariableNames', 0 , 'ReadRowNames', 0,'Format','%s%s');
                x = ones(size(z,1),1).*set;
                y = repmat(sensor,size(x,1));
                y = y(:,1);
                w = [y x table2array(z)];
                dump = [dump; w];
             end
            [~,idx]=sort(double(string(dump(:,3))));
            Sensors_data=dump(idx,:)

%         Sensors_data = sortrows(dump,3);
    end
%             row_idx = (contains(Sensors_data(:, end), 'FFFE9A4A5BAB' ));
%             b=af(row_idx,:)

%% Generate feedback dump
if exist("feedback_dump",'var') == 0
    feedback_dump = [];
    fields = fieldnames(User_feelings)
    for i = 1:numel(fields)
        z = repmat((fields{i}),size(User_feelings.(fields{i}).x));
        out = [User_feelings.(fields{i}).x User_feelings.(fields{i}).Var1 User_feelings.(fields{i}).Var2 z]
      feedback_dump = [feedback_dump; out];
    end
    fields = fieldnames(User_perceptions)
    for i = 1:numel(User_perceptions)
        z = repmat((fields{i}),size(User_perceptions.(fields{i}).x));
        out = [User_perceptions.(fields{i}).x User_perceptions.(fields{i}).Var1 User_perceptions.(fields{i}).Var2 z]
      feedback_dump = [feedback_dump; out];
    end
    feedback_dump = sortrows(feedback_dump,2);
end


%%
    disp("All done!");
    logger("All files", 
    allfiles = af;
    varcl = {'User_feelings', 'User_perceptions', 'allfiles', 'user_f', 'user_p','sensorfiles','Sensors_data','feedback_dump'};
    clearvars('-except',varcl{:});
    save("domusdata");

 
function statusdot(iter,total)
    split=iter/total*100;
    if iter==1
        fprintf(1,'\t%5.2f%%',split); pause(.1)
    else
        fprintf(1,'\t\b\b\b\b\b\b\b%5.2f%%',split); pause(.1)
    end
end

function [txt]=txtpadding(txt,chr,len)
    s=len-strlength(txt);
    c=repmat(char(chr),[1 s]);
    txt=txt+c;
end