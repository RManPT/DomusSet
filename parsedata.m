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
Sensors_info =readtable('relevant_sensors.csv', 'FileType', 'text', 'Delimiter', ';', 'ReadVariableNames', 0,...
    'ReadRowNames', 0,'Format','%s%s%s%s', 'FileEncoding','UTF-8');
 Sensors_info = table2array(Sensors_info);

%% associate sensors with feelings and perceptions
Temperature = ["FFFE9DA3A50A" "FFFEB8A8CCBB"];
Humidity = ["FFFE3CE1BCAA"];
Luminosity = ["FFFE48CA9395" "FFFE659CDFB3" "FFFE2B37EAB9" "FFFEA4ACFDCC" "FFFEDC6CAA6A" "FFFE8CC9BAD0"];


%% Extract only relevant sensors
Temperature_data = [];
Humidity_data = [];
Luminosity_data= [];

Temperature_data = extractSensor(Sensors_data,1,Temperature_data,Temperature);  
Humidity_data = extractSensor(Sensors_data,1,Humidity_data,Humidity);  
Luminosity_data = extractSensor(Sensors_data,1,Luminosity_data,Luminosity); 

%% remove experiments from sensor dump
Temperature_data = removeSensor(Temperature_data,1,exper);
Humidity_data = removeSensor(Humidity_data,1,exper);
Luminosity_data = removeSensor(Luminosity_data,1,exper);

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


%% Extract first third of Temperature reads for each experiment (Office)
e = doubleSortUnique(Sensors_data,2);
% to_name=[];
% % for i=1:size(user_f,2)
%     row_idx = (contains(User_feelings.Temperature.x, "1" ));
% %     [row_idx, ~] = find(User_feelings.Temperature(:, 1) == "1");
%     to_name=[to_name; User_feelings.Temperature(row_idx).Var1 ];  
% % % end

%     t1=[];
%     row_idx = (contains(Sensors_clean_data(:, 1), lower(Temperature(1) )));
%     w1=[w1; Sensors_clean_data(row_idx,3) Sensors_clean_data(row_idx,4)];  
% 
%     t2=[];
%     row_idx = (contains(Sensors_clean_data(:, 1), lower(Temperature(2) )));
%     w2=[w2; Sensors_clean_data(row_idx,3) Sensors_clean_data(row_idx,4)];  
% 
%    

%% Getting first and last feedbacks from each experiment to determin start and end times
% d = sortrows([Temperature_feelings;Humidity_feelings;Luminosity_feelings],2);



% w=Sensors_data;
%  for i=1:size(Sensors_info,1)
%     row_idx = (contains(w(:, 1), lower(Sensors_info(i,4)) ));
%     w=[w; w(row_idx,1) w(row_idx,2) w(row_idx,3) w(row_idx,4) ];  
% %     w=[w Sensors_clean_data(:,1) Sensors_clean_data(:,2) Sensors_clean_data(:,3) Sensors_clean_data(:,4) ]; 
% end    
% % Sensors_info{55,4}
% w=[];
% % w1=[];
% % % w2=[];
% % %  for i=1:size(Sensors_info,1)
% %     row_idx = (contains(Sensors_data(:, 1), lower(Sensors_info(7,4)) ));
%      row_idx = (contains(Sensors_clean_data(:, 3), lower("FFFE395A4D9C") ));
% % %      [row_idx, ~] = find(User_Perceptions.ThermalComfort{:, 3} == lower("10"));
% % 
% %     w1=[w1; Sensors_data(row_idx,1) Sensors_data(row_idx,2) Sensors_data(row_idx,3) Sensors_data(row_idx,4) ];  
% %      w=[w; User_Perceptions.GlobalComfort(row_idx,1) User_Perceptions.GlobalComfort(row_idx,2) User_Perceptions.GlobalComfort(row_idx,3) ];  
%     w=[w Sensors_clean_data(row_idx,1) Sensors_clean_data(row_idx,2) Sensors_clean_data(row_idx,3) Sensors_clean_data(row_idx,4) ]; 
% % end    

%% plot sensor
            [row_idx, ~] = find(feedback_dump(:, 1) == "22");
            info=feedback_dump(row_idx,:); 
%             e = unique( info(:,2));
            [C,ia,ic] = unique(info(:,2),'rows')
            info = info(ia,:)
            names1 = datestr(datetime(str2double(info(:,2))/1000, 'ConvertFrom', 'posixtime'));
            names2 = info(:,4);
z=[];
% v = @(info) [info(:,1) extractBefore(info(:,2), 12)+"00" info(:,3) info(:,4)];
%  out=v(info)names
%%

% for i=1:size(w,1)
%    w(i,5)=datetime(str2num(char(Sensors_clean_data(i,3)))/1000,'ConvertFrom', 'posixtime'); 
% end    



%% get start and end datetime for remaining experiments
% e = unique( w(:,2));
% e=sortrows(e,1);
%  from_mame=[];
%  z=[];
% for i=1:size(e,1)
%        [row_idx, ~] = find(w(:, 2) == e(i));
%         from_mame=w(row_idx,:);
%         z = [z; {datetime(str2num(char(from_mame(1,3)))/1000,'ConvertFrom', 'posixtime')} {datetime(str2num(char(from_mame(end-1,3)))/1000,'ConvertFrom', 'posixtime')} ];
% end 
% z=[e z];
%% clean and save

varcl = {'User_feelings', 'User_perceptions', 'allfiles', 'user_f', 'user_p','sensorfiles','Sensors_data', 'Sensors_info', 'readings_dump', 'z'...
         'Temperature_data', 'Temperature_feelings', 'Humidity_data', 'Humidity_feelings', 'Luminosity_data', 'Luminosity_feelings','d','exp_times'};
% clearvars('-except',varcl{:});

%% Auxiliary functions

% funtion to remove every item on "what" from "from_name"
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
function [out]=extractSensor(from_mame,from_col,to_name,what)
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
