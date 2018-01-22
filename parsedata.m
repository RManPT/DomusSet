clc;
close all;
clear all;
load("domusdata");
% water = ["FFFE395A4D9C", "FFFE8A746A6D", "FFFE3E7AA49B", "FFFEDAABBCB5"];
% elect = ["FFFED998E65A", "FFFEDBAABA48", "FFFEDBB898DE", "FFFE755B9A41", "FFFE7AA3A7CE"];
% openi = ["FFFE793BF9A3","FFFE8D5B3199","FFFECAAA7D8F","FFFE79B6B39C","FFFE1EC74CB8", ...
%          "FFFE9C5EBCD8","FFFECABA26B6","FFFEB595A7B1","FFFE8658CAAA","FFFE7AAB3AA5", ...
%          "FFFE17BAB4BA","FFFEAA5ACE9D","FFFEB8A8DA6A","FFFE9B5B62C8","FFFE919B82B3"];
% misc = ["FFFE8AAA49B5","FFFE98E7BCDD","FFFE59188D82"];
% weath = ["FFFEA94554AA","FFFEAA37796B","FFFE3EC6C939","FFFE9A4A5BAB","FFFEC7BCDDE9","FFFE8B34ABAC"];
% power = ["FFFE67DAA0C3" "FFFEAA3DE849" "FFFE8EA1E6DD" "FFFED3E7ECEB" "FFFEDA97BB69" "FFFEB853BA76" "FFFEAB498E8A" "FFFEAA6A458E" "FFFEBB9B539B" "FFFE98D7DAA8"];
exper = ["9" "24" "4" "5" "8" "1"];
% %% remove uneeded sensors 
% Sensors_clean_data = removeSensor(Sensors_data,1,water);
% Sensors_clean_data = removeSensor(Sensors_clean_data,1,elect);
% Sensors_clean_data = removeSensor(Sensors_clean_data,1,openi);
% Sensors_clean_data = removeSensor(Sensors_clean_data,1,misc);
% Sensors_clean_data = removeSensor(Sensors_clean_data,1,weath);
% Sensors_clean_data = removeSensor(Sensors_clean_data,1,power);


%% get info on relevant sensors
% Sensors_info =readtable('relevant_sensors.csv', 'FileType', 'text', 'Delimiter', ';', 'ReadVariableNames', 0,...
%     'ReadRowNames', 0,'Format','%s%s%s%s', 'FileEncoding','UTF-8');
%  Sensors_info = table2array(Sensors_info);

%% associate sensors with location, feelings and perceptions
Office_Temperature = ["FFFE9DA3A50A"];
Bedroom_Temperature = ["FFFEB8A8CCBB"];
Kitchen_Temperature = [];

Humidity = ["FFFE3CE1BCAA"];

Kitchen_Luminosity = ["FFFE48CA9395" "FFFE2B37EAB9"];
Bedroom_Luminosity = ["FFFE659CDFB3" "FFFEA4ACFDCC"];
Office_Luminosity = ["FFFEDC6CAA6A" "FFFE8CC9BAD0"];


%% Extract only relevant sensors
Office_Temperature_data = [];
Bedroom_Temperature_data = [];
Kitchen_Temperature_data = [];

Humidity_data = [];

Office_Luminosity_data1= [];
Bedroom_Luminosity_data1= [];
Kitchen_Luminosity_data1= [];
Office_Luminosity_data2= [];
Bedroom_Luminosity_data2= [];
Kitchen_Luminosity_data2= [];

Office_Temperature_data = extractSensor(Sensors_data,1,Office_Temperature);  
Bedroom_Temperature_data = extractSensor(Sensors_data,1,Bedroom_Temperature); 
Kitchen_Temperature_data = extractSensor(Sensors_data,1,Kitchen_Temperature); 

Humidity_data = extractSensor(Sensors_data,1,Humidity);  

Office_Luminosity_data1 = extractSensor(Sensors_data,1,Office_Luminosity(1)); 
Bedroom_Luminosity_data1 = extractSensor(Sensors_data,1,Bedroom_Luminosity(1)); 
Kitchen_Luminosity_data1 = extractSensor(Sensors_data,1,Kitchen_Luminosity(1)); 

Office_Luminosity_data2 = extractSensor(Sensors_data,1,Office_Luminosity(2)); 
Bedroom_Luminosity_data2 = extractSensor(Sensors_data,1,Bedroom_Luminosity(2)); 
Kitchen_Luminosity_data2 = extractSensor(Sensors_data,1,Kitchen_Luminosity(2));


%% Extract only relevant feelings
Temperature_feelings = [];
Humidity_feelings = [];
Luminosity_feelings = [];
Temperature_feelings = extractFeelings(User_feelings.Temperature);  
Humidity_feelings = extractFeelings(User_feelings.Humidity);  
Luminosity_feelings = extractFeelings(User_feelings.Luminosity); 

%% remove experiments from feelings dump
Temperature_feelings = removeSensor(Temperature_feelings,1,exper);
Humidity_feelings = removeSensor(Humidity_feelings,1,exper);
Luminosity_feelings = removeSensor(Luminosity_feelings,1,exper);

%% Extract only relevant perception
Global_perception = [];
Thermal_perception = [];
Lighting_perception = [];

Global_perception = extractFeelings(User_perceptions.GlobalComfort);  
Thermal_perception = extractFeelings(User_perceptions.ThermalComfort);  
Lighting_perception = extractFeelings(User_perceptions.LightingComfort); 

%% remove experiments from perceptions dump
Global_perception = removeSensor(Global_perception,1,exper);
Thermal_perception = removeSensor(Thermal_perception,1,exper);
Lighting_perception = removeSensor(Lighting_perception,1,exper);


%% Getting first and last feedbacks from each experiment to determin start and end times
d = sortrows([Temperature_feelings;Humidity_feelings;Luminosity_feelings;Global_perception;Thermal_perception;Lighting_perception],2);
exp_times=getExperimentTimes(d,1,2);


%% Extract batches of Temperature feelings for each experiment (Office/Bedroom/Kitchen)
TFparsed1 = parseData(Temperature_feelings,exp_times,1);
TFparsed2 = parseData(Temperature_feelings,exp_times,2);
TFparsed3 = parseData(Temperature_feelings,exp_times,3);

% %% Extract batches of Humidity feelings for each experiment (Office/Bedroom/Kitchen)
% HFparsed1 = parseData(Humidity_feelings,exp_times,1);
% HFparsed2 = parseData(Humidity_feelings,exp_times,2);
% HFparsed3 = parseData(Humidity_feelings,exp_times,3);

%% Extract batches of Luminosity feelings for each experiment (Office/Bedroom/Kitchen)
LFparsed1 = parseData(Luminosity_feelings,exp_times,1);
LFparsed2 = parseData(Luminosity_feelings,exp_times,2);
LFparsed3 = parseData(Luminosity_feelings,exp_times,3);

%% Extract batches of Temperature perception for each experiment (Office/Bedroom/Kitchen)
TPparsed1 = parseData(Thermal_perception,exp_times,1);
TPparsed2 = parseData(Thermal_perception,exp_times,2);
TPparsed3 = parseData(Thermal_perception,exp_times,3);

%% Extract batches of Luminosity perception for each experiment (Office/Bedroom/Kitchen)
LPparsed1 = parseData(Lighting_perception,exp_times,1);
LPparsed2 = parseData(Lighting_perception,exp_times,2);
LPparsed3 = parseData(Lighting_perception,exp_times,3);

%% Extract batches of Global Comfort perception for each experiment (Office/Bedroom/Kitchen)
GPparsed1 = parseData(Global_perception,exp_times,1);
GPparsed2 = parseData(Global_perception,exp_times,2);
GPparsed3 = parseData(Global_perception,exp_times,3);

%% tests and sh!t

% v = @(info) [info(:,1) extractBefore(info(:,2), 12)+"00" info(:,3) info(:,4)];
%  out=v(info)names

%% Prepare temperature data
Office_Temperature_data = sortrows(Office_Temperature_data,2);
TFparsed1 = sortrows(TFparsed1,2);

Bedroom_Temperature_data = sortrows(Bedroom_Temperature_data,2);
TFparsed2 = sortrows(TFparsed2,2);

x=str2double(Office_Temperature_data(:,1:3));
y=str2double(Bedroom_Temperature_data(:,1:3));
[I, J] = samplealign(x(:,2:3), y(:,2:3));
z = [Office_Temperature_data(I,:) Bedroom_Temperature_data(J,:)];
B=arrayfun(@string,z);
Kitchen_Temperature_data = [B(B(:,3)>B(:,6),1:3); B(B(:,3)<B(:,6),4:6)];
Kitchen_Temperature_data = sortrows(Kitchen_Temperature_data,2);
TFparsed3 = sortrows(TFparsed3,2);

TPparsed1 = sortrows(TPparsed1,2);
TPparsed2 = sortrows(TPparsed2,2);
TPparsed3 = sortrows(TPparsed3,2);

%% Prepare luminosity data
Office_Luminosity_data1 = sortrows(Office_Luminosity_data1,2); 
Bedroom_Luminosity_data1 = sortrows(Bedroom_Luminosity_data1,2); 
Kitchen_Luminosity_data1 = sortrows(Kitchen_Luminosity_data1,2);

Office_Luminosity_data2 = sortrows(Office_Luminosity_data2,2);
Bedroom_Luminosity_data2 = sortrows(Bedroom_Luminosity_data2,2);
Kitchen_Luminosity_data2 = sortrows(Kitchen_Luminosity_data2,2);


LFparsed1 = sortrows(LFparsed1,2);
LFparsed2 = sortrows(LFparsed2,2);
LFparsed3 = sortrows(LFparsed3,2);


LPparsed1 = sortrows(LPparsed1,2);
LPparsed2 = sortrows(LPparsed2,2);
LPparsed3 = sortrows(LPparsed3,2);
% x1=str2double(Office_Luminosity_data1(:,1:3));
% y1=str2double(Bedroom_Luminosity_data1(:,1:3));
% z1=str2double(Kitchen_Luminosity_data1(:,1:3));
% 
% [Q1, W1, E1] = samplealign(x1(:,2:3), y1(:,2:3), z1(:,2:3));
% zz1 = [Office_Luminosity_data1(Q1,:) Bedroom_Luminosity_data1(W1,:) Kitchen_Luminosity_data1(E1,:)];
% B=arrayfun(@string,zz1);
% 
% x2=str2double(Office_Luminosity_data2(:,1:3));
% y2=str2double(Bedroom_Luminosity_data2(:,1:3));
% z2=str2double(Kitchen_Luminosity_data2(:,1:3));
% 
% [Q2, W2, E2] = samplealign(x2(:,2:3), y2(:,2:3), z2(:,2:3));
% zz2 = [Office_Luminosity_data1(Q2,:) Bedroom_Luminosity_data1(W2,:) Kitchen_Luminosity_data1(E2,:)];
% B=arrayfun(@string,zz2);

%% Prepare global data
GPparsed1 = sortrows(GPparsed1,2);
GPparsed2 = sortrows(GPparsed2,2);
GPparsed3 = sortrows(GPparsed3,2);


%% remove experiments from sensor dump
Office_Temperature_data = removeSensor(Office_Temperature_data,1,exper);
Bedroom_Temperature_data = removeSensor(Bedroom_Temperature_data,1,exper);
Kitchen_Temperature_data = removeSensor(Kitchen_Temperature_data,1,exper);

Humidity_data = removeSensor(Humidity_data,1,exper);

Office_Luminosity_data1 = removeSensor(Office_Luminosity_data1,1,exper);
Bedroom_Luminosity_data1 = removeSensor(Bedroom_Luminosity_data1,1,exper);
Kitchen_Luminosity_data1 = removeSensor(Kitchen_Luminosity_data1,1,exper);

Office_Luminosity_data2 = removeSensor(Office_Luminosity_data2,1,exper);
Bedroom_Luminosity_data2 = removeSensor(Bedroom_Luminosity_data2,1,exper);
Kitchen_Luminosity_data2 = removeSensor(Kitchen_Luminosity_data2,1,exper);


% Luminosity_data = removeSensor(Luminosity_data,1,exper);

%% prepare SVM vector for Temperature

%Office
Xtemp=[]; Ytemp=[]; 
for i=1:size(TFparsed1,1)
    [min_val,ii]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(TFparsed1(i,2))));
    Xtemp=[Xtemp; Office_Temperature_data(ii,3)];
    Ytemp=[Ytemp; TFparsed1(i,3)];
%     z = [z; TFparsed1(i,1) Office_Temperature_data(ii,1) TFparsed1(i,2) Office_Temperature_data(ii,2) TFparsed1(i,3) Office_Temperature_data(ii,3)];
end
for i=1:size(TFparsed2,1)
    [min_val,ii]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(TFparsed2(i,2))));
    Xtemp=[Xtemp; Bedroom_Temperature_data(ii,3)];
    Ytemp=[Ytemp; TFparsed2(i,3)];
end
for i=1:size(TFparsed3,1)
    [min_val,ii]=min(abs(str2double(Kitchen_Temperature_data(:,2))-str2double(TFparsed3(i,2))));
    Xtemp=[Xtemp; Kitchen_Temperature_data(ii,3)];
    Ytemp=[Ytemp; TFparsed3(i,3)];
end

% Xtemp2=[]; Ytemp2=[]; 
% Z=[Office_Temperature_data;Bedroom_Temperature_data];
%   for i=1:size(Temperature_feelings,1)
%     [min_val,ii]=min(abs(str2double(Z(:,2))-str2double(Temperature_feelings(i,2))));
%     Xtemp2=[Xtemp2; Z(ii,3)];
%     Ytemp2=[Ytemp2; Temperature_feelings(i,3)];
%   end
%% prepare SVM vector for Humidity
  Xhumi=[]; Yhumi=[];
  for i=1:size(Humidity_feelings,1)
    [min_val,ii]=min(abs(str2double(Humidity_data(:,2))-str2double(Humidity_feelings(i,2))));
    Xhumi=[Xhumi; Humidity_data(ii,3)];
    Yhumi=[Yhumi; Humidity_feelings(i,3)];
  end

    %% padding classes Temperature
    [Xtemp_padded,Ytemp_padded] = padding(Xtemp,Ytemp);
%     [Xtemp2_padded,Ytemp2_padded] = padding(Xtemp2,Ytemp2);

%% prepare SVM vector for Lighting

%Office
Xlum=[]; Ylum=[]; 
for i=1:size(LFparsed1,1)
    [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(LFparsed1(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(LFparsed1(i,2))));
    Xlum=[Xlum; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3)];
% Xlum=[Xlum; Office_Luminosity_data2(iii,3) ];
    Ylum=[Ylum; LFparsed1(i,3)];
end
%Bedroom
for i=1:size(LFparsed2,1)
   [min_val,ii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(LFparsed2(i,2))));
    [min_val,iii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(LFparsed2(i,2))));
    Xlum=[Xlum; Bedroom_Luminosity_data1(ii,3) Bedroom_Luminosity_data2(iii,3)];
%  Xlum=[Xlum; Bedroom_Luminosity_data2(iii,3) ];
    Ylum=[Ylum; LFparsed2(i,3)];
end
%Kitchen
for i=1:size(LFparsed3,1)
    [min_val,ii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(LFparsed3(i,2))));
    [min_val,iii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(LFparsed3(i,2))));
    Xlum=[Xlum; Kitchen_Luminosity_data1(ii,3) Kitchen_Luminosity_data2(iii,3)];
% Xlum=[Xlum; Kitchen_Luminosity_data2(iii,3) ];
    Ylum=[Ylum; LFparsed3(i,3)];
end

% Xtemp2=[]; Ytemp2=[]; 
% Z=[Office_Temperature_data;Bedroom_Temperature_data];
%   for i=1:size(Temperature_feelings,1)
%     [min_val,ii]=min(abs(str2double(Z(:,2))-str2double(Temperature_feelings(i,2))));
%     Xtemp2=[Xtemp2; Z(ii,3)];
%     Ytemp2=[Ytemp2; Temperature_feelings(i,3)];
%   end

    %% padding classes Luminosity
    [c1,Ylum_padded] = padding(Xlum(:,1),Ylum);
    [c2,Ylum_padded] = padding(Xlum(:,2),Ylum);
    Xlum_padded = [c1 c2];
%     [Xtemp2_padded,Ytemp2_padded] = padding(Xtemp2,Ylum2);

%% prepare SVM vector for Thermal Comfort

%Office
Xther=[]; Yther=[]; 
for i=1:size(TPparsed1,1)
    [min_val,ii]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(TPparsed1(i,2))));
    [min_val,iii]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(TPparsed1(i,2))));
    Xther=[Xther; Office_Temperature_data(ii,3) Bedroom_Temperature_data(iii,3)];
    Yther=[Yther; TPparsed1(i,3)];
end
%Bedroom
for i=1:size(TPparsed2,1)
   [min_val,ii]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(TPparsed2(i,2))));
    [min_val,iii]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(TPparsed2(i,2))));
    Xther=[Xther; Office_Temperature_data(ii,3) Bedroom_Temperature_data(iii,3)];
    Yther=[Yther; TPparsed2(i,3)];
end
%Kitchen
for i=1:size(TPparsed3,1)
    [min_val,ii]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(TPparsed3(i,2))));
    [min_val,iii]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(TPparsed3(i,2))));
    Xther=[Xther; Office_Temperature_data(ii,3) Bedroom_Temperature_data(iii,3)];
    Yther=[Yther; TPparsed3(i,3)];
end

%% padding classes Thermal
    [d1,Yther_padded] = padding(Xther(:,1),Yther);
    [d2,Yther_padded] = padding(Xther(:,2),Yther);
    Xther_padded = [d1 d2];

%% prepare SVM vector for Lighting Comfort

%Office
Xlig=[]; Ylig=[]; 
for i=1:size(TPparsed1,1)
    [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(TPparsed1(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(TPparsed1(i,2))));
    [min_val,iiii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(TPparsed1(i,2))));
    [min_val,iiiii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(TPparsed1(i,2))));
    [min_val,iiiiii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(TPparsed1(i,2))));
    [min_val,iiiiiii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(TPparsed1(i,2))));
    Xlig=[Xlig; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3) Bedroom_Luminosity_data1(iiii,3) Bedroom_Luminosity_data2(iiiii,3) Kitchen_Luminosity_data1(iiiiii,3) Kitchen_Luminosity_data2(iiiiiii,3)];
    Ylig=[Ylig; TPparsed1(i,3)];
end
%Bedroom
for i=1:size(TPparsed2,1)
   [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(TPparsed2(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(TPparsed2(i,2))));
    [min_val,iiii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(TPparsed2(i,2))));
    [min_val,iiiii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(TPparsed2(i,2))));
    [min_val,iiiiii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(TPparsed2(i,2))));
    [min_val,iiiiiii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(TPparsed2(i,2))));
    Xlig=[Xlig; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3) Bedroom_Luminosity_data1(iiii,3) Bedroom_Luminosity_data2(iiiii,3) Kitchen_Luminosity_data1(iiiiii,3) Kitchen_Luminosity_data2(iiiiiii,3)];
    Ylig=[Ylig; TPparsed2(i,3)];
end
%Kitchen
for i=1:size(TPparsed3,1)
    [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(TPparsed3(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(TPparsed3(i,2))));
    [min_val,iiii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(TPparsed3(i,2))));
    [min_val,iiiii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(TPparsed3(i,2))));
    [min_val,iiiiii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(TPparsed3(i,2))));
    [min_val,iiiiiii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(TPparsed3(i,2))));
    Xlig=[Xlig; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3) Bedroom_Luminosity_data1(iiii,3) Bedroom_Luminosity_data2(iiiii,3) Kitchen_Luminosity_data1(iiiiii,3) Kitchen_Luminosity_data2(iiiiiii,3)];
    Ylig=[Ylig; TPparsed3(i,3)];
end

%% padding classes Lighting
    [f1,Ylig_padded] = padding(Xlig(:,1),Ylig);
    [f2,Ylig_padded] = padding(Xlig(:,2),Ylig);
    [f3,Ylig_padded] = padding(Xlig(:,3),Ylig);
    [f4,Ylig_padded] = padding(Xlig(:,4),Ylig);
    [f5,Ylig_padded] = padding(Xlig(:,5),Ylig);
    [f6,Ylig_padded] = padding(Xlig(:,6),Ylig);
    Xlig_padded = [f1 f2 f3 f4 f5 f6];

%% prepare SVM vector for Global Comfort

%Office
Xglo=[]; Yglo=[]; 
for i=1:size(GPparsed1,1)
    [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(GPparsed1(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(GPparsed1(i,2))));
    [min_val,iiii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(GPparsed1(i,2))));
    [min_val,iiiii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(GPparsed1(i,2))));
    [min_val,iiiiii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(GPparsed1(i,2))));
    [min_val,iiiiiii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(GPparsed1(i,2))));

    [min_val,x]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(GPparsed1(i,2))));
    [min_val,xx]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(GPparsed1(i,2))));
    [min_val,xxx]=min(abs(str2double(Kitchen_Temperature_data(:,2))-str2double(GPparsed1(i,2))));
    [min_val,xxxx]=min(abs(str2double(Humidity_data(:,2))-str2double(GPparsed1(i,2))));

    Xglo=[Xglo; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3) Bedroom_Luminosity_data1(iiii,3) Bedroom_Luminosity_data2(iiiii,3) Kitchen_Luminosity_data1(iiiiii,3) Kitchen_Luminosity_data2(iiiiiii,3) Office_Temperature_data(x,3) Bedroom_Temperature_data(xx,3) Kitchen_Temperature_data(xxx,3) Humidity_data(xxxx,3)];
    Yglo=[Yglo; GPparsed1(i,3)];
end
%Bedroom
for i=1:size(GPparsed2,1)
   [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(GPparsed2(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(GPparsed2(i,2))));
    [min_val,iiii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(GPparsed2(i,2))));
    [min_val,iiiii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(GPparsed2(i,2))));
    [min_val,iiiiii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(GPparsed2(i,2))));
    [min_val,iiiiiii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(GPparsed2(i,2))));

    [min_val,x]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(GPparsed2(i,2))));
    [min_val,xx]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(GPparsed2(i,2))));
    [min_val,xxx]=min(abs(str2double(Kitchen_Temperature_data(:,2))-str2double(GPparsed2(i,2))));
    [min_val,xxxx]=min(abs(str2double(Humidity_data(:,2))-str2double(GPparsed2(i,2))));

    Xglo=[Xglo; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3) Bedroom_Luminosity_data1(iiii,3) Bedroom_Luminosity_data2(iiiii,3) Kitchen_Luminosity_data1(iiiiii,3) Kitchen_Luminosity_data2(iiiiiii,3) Office_Temperature_data(x,3) Bedroom_Temperature_data(xx,3) Kitchen_Temperature_data(xxx,3) Humidity_data(xxxx,3)];
    Yglo=[Yglo; GPparsed2(i,3)];
end
%Kitchen
for i=1:size(GPparsed3,1)
    [min_val,ii]=min(abs(str2double(Office_Luminosity_data1(:,2))-str2double(GPparsed3(i,2))));
    [min_val,iii]=min(abs(str2double(Office_Luminosity_data2(:,2))-str2double(GPparsed3(i,2))));
    [min_val,iiii]=min(abs(str2double(Bedroom_Luminosity_data1(:,2))-str2double(GPparsed3(i,2))));
    [min_val,iiiii]=min(abs(str2double(Bedroom_Luminosity_data2(:,2))-str2double(GPparsed3(i,2))));
    [min_val,iiiiii]=min(abs(str2double(Kitchen_Luminosity_data1(:,2))-str2double(GPparsed3(i,2))));
    [min_val,iiiiiii]=min(abs(str2double(Kitchen_Luminosity_data2(:,2))-str2double(GPparsed3(i,2))));

    [min_val,x]=min(abs(str2double(Office_Temperature_data(:,2))-str2double(GPparsed3(i,2))));
    [min_val,xx]=min(abs(str2double(Bedroom_Temperature_data(:,2))-str2double(GPparsed3(i,2))));
    [min_val,xxx]=min(abs(str2double(Kitchen_Temperature_data(:,2))-str2double(GPparsed3(i,2))));
    [min_val,xxxx]=min(abs(str2double(Humidity_data(:,2))-str2double(GPparsed3(i,2))));

    Xglo=[Xglo; Office_Luminosity_data1(ii,3) Office_Luminosity_data2(iii,3) Bedroom_Luminosity_data1(iiii,3) Bedroom_Luminosity_data2(iiiii,3) Kitchen_Luminosity_data1(iiiiii,3) Kitchen_Luminosity_data2(iiiiiii,3) Office_Temperature_data(x,3) Bedroom_Temperature_data(xx,3) Kitchen_Temperature_data(xxx,3) Humidity_data(xxxx,3)];
    Yglo=[Yglo; GPparsed3(i,3)];
end

%% padding classes Global
    [g1,Yglo_padded] = padding(Xglo(:,1),Yglo);
    [g2,Yglo_padded] = padding(Xglo(:,2),Yglo);
    [g3,Yglo_padded] = padding(Xglo(:,3),Yglo);
    [g4,Yglo_padded] = padding(Xglo(:,4),Yglo);
    [g5,Yglo_padded] = padding(Xglo(:,5),Yglo);
    [g6,Yglo_padded] = padding(Xglo(:,6),Yglo);
    [g7,Yglo_padded] = padding(Xglo(:,7),Yglo);
    [g8,Yglo_padded] = padding(Xglo(:,8),Yglo);
    [g9,Yglo_padded] = padding(Xglo(:,9),Yglo);
    [g10,Yglo_padded] = padding(Xglo(:,10),Yglo);
    Xglo_padded = [g1 g2 g3 g4 g5 g6 g7 g8 g9 g10];
%% clean and save

varcl = {'User_feelings', 'User_perceptions', 'allfiles', 'user_f', 'user_p','sensorfiles','Sensors_data', 'Sensors_info','feedback_dump', ...
         'Xglo', 'Xglo_padded', 'Xhumi', 'Xlig', 'Xlig_padded', 'Xlum', 'Xlum_padded','Xtemp','Xtemp_padded','Xther','Xther_padded',...
         'Yglo', 'Yglo_padded', 'Yhumi', 'Ylig', 'Ylig_padded', 'Ylum', 'Ylum_padded','Ytemp','Ytemp_padded','Yther','Yther_padded'};
clearvars('-except',varcl{:});

save domusdata;

%% Auxiliary functions

function [out]=parseData(data_source,exp_times,third)
    %extract unique experiments
    e = unique( data_source(:,1));
    t=[]; w=[];
    for i=1:size(e,1)
       [row_idx, ~] = find(data_source(:, 1) == e(i));
       t=data_source(row_idx,:);
       [row_idx, ~] = find(exp_times(:, 1) == e(i));
       t2=exp_times(row_idx,:); 
       ini_exp = str2double(t2(1,4));
       fim_exp = str2double(t2(1,5));
       batch=(fim_exp-ini_exp)/3;
       start_time = ini_exp+batch*(third-1);
       end_time = ini_exp+batch*(third);
       x = t(str2double(t(:,2)) >= start_time & str2double(t(:,2)) <= end_time,:);
%        z = string(ones(size(x,1),1)*str2double(e(i)));
        w=[w; x];
       
    end
    out=w;
end

% function to remove every item on "what" from "from_name"
function [out]=removeSensor(from_mame,from_col,what)
for i=1:size(what,2)
%     row_idx = (~contains(from_mame(:, from_col), lower(what(i)) ));
    [row_idx, ~] = find(from_mame(:, from_col) ~= what(i));
    from_mame=from_mame(row_idx,:);
end
out=from_mame;
end

% funtion to append every item on "what" from "form_name/from_col" to
% "to_name"
function [out]=extractSensor(from_mame,from_col,what)
 to_name=[];
for i=1:size(what,2)
   
%     row_idx = (~contains(from_mame(:, from_col), lower(what(i)) ));
    [row_idx, ~] = find(from_mame(:, from_col) == lower(what(i)));
    to_name=[to_name; from_mame(row_idx,2) from_mame(row_idx,3) from_mame(row_idx,4) ];  
end
out=to_name;
end

function [out]=extractFeelings(feelings)
     out = [feelings.x feelings.Var1 feelings.Var2] ;
end

%% Extracts and returns experiments start and end times (Julian)
% data_source : array with Sensors data
% exp_idx : experiment column index
% time_idx : posix colummn index
% returns [ experiment_id start_time_julian end_time_julian
% start_time_posix end_time_posix]
function [out]=getExperimentTimes(data_source,exp_idx,time_idx)
e = unique( data_source(:,exp_idx));
exp_times=[];
for i=1:size(e,1)
       [row_idx, ~] = find(data_source(:, exp_idx) == e(i));
        from_mame=data_source(row_idx,:);
        exp_start = datetime(str2num(char(from_mame(1,time_idx)))/1000,'ConvertFrom', 'posixtime');
        exp_end = datetime(str2num(char(from_mame(end-1,time_idx)))/1000,'ConvertFrom', 'posixtime');
        exp_times = [exp_times; e(i) datestr(exp_start) datestr(exp_end) from_mame(1,time_idx) from_mame(end-1,time_idx)];
end 
[~,idx]=sort(double(string(exp_times(:,1))));
out=exp_times(idx,:);
end

function [out]=doubleSortUnique(data_source,row_idx)
    e = unique( data_source(:,row_idx));
    [~,idx]=sort(double(string(e(:,1))));
    out=e(idx,:);
end

function [Xtemp,Ytemp]=padding(Xtemp,Ytemp)
    c=[]; v=[];
    for i=1:10
        c=[c; i double(length(Xtemp(find(Ytemp==string(i)))))];
        b = double(mean(double(Xtemp(find(Ytemp==string(i))))));
        if isnan(b) 
            if i<10 b=double(min(double(Xtemp(find(Ytemp==string(i+1)))))); 
            else
                i=double(max(double(Xtemp(find(Ytemp==string(i-1))))));
            end
        end
        v=[v; b]; 
    end
    c=[c v];
    c1 = max(c(:,2))-c(:,2);
    c=[c c1];
    for i=1:size(c,1), for j=1:c(i,4), Xtemp=[Xtemp; c(i,3)]; Ytemp=[Ytemp; i];, end, end
end
