function [accuracy]=traindata(machine,state)
    load("domusdata");

switch machine
    case 1
        if (state=='On')
            %% Train Temperature SVM 1
            X=str2double(Xtemp);
            Y=str2double(Ytemp);  
            model_Temperature = trainSVM(X,Y);
        elseif (state=='Padded')    
            %% Train Temperature SVM 1 padded
            X=str2double(Xtemp_padded);
            Y=str2double(Ytemp_padded);  
            model_Temperature_padded = trainSVM(X,Y);
        end
    
        % %% Train Temperature SVM 2
        %     
        %     X=str2double(Xtemp2);
        %     Y=str2double(Ytemp2);  
        %     model_Temperature2 = trainSVM(X,Y);
        %   
        % %% Train Temperature SVM 2 padded
        %     
        %     X=str2double(Xtemp2_padded);
        %     Y=str2double(Ytemp2_padded);  
        %     model_Temperature2_padded = trainSVM(X,Y);
    case 2
        if (state=='On')
            %% Train Humidity SVM 
            X=str2double(Xhumi);
            Y=str2double(Yhumi);
            model_Humidity = trainSVM(X,Y);
        elseif (state=='Padded')    

        end
    case 3
        if (state=='On')
            %% Train Luminosity SVM 
            X=str2double(Xlum);
            Y=str2double(Ylum);
            model_Luminosity = trainSVM(X,Y);  
        elseif (state=='Padded')    
            %% Train Luminosity SVM padded
            X=str2double(Xlum_padded);
            Y=str2double(Ylum_padded);
            model_Luminosity_padded = trainSVM(X,Y);  
        end
    case 4
        if (state=='On')
            %% Train Global SVM 
            X=str2double(Xglo);
            Y=str2double(Yglo);  
            model_Global = trainSVM(X,Y);
        elseif (state=='Padded')    
            %% Train Global SVM padded 
            X=str2double(Xglo_padded);
            Y=str2double(Yglo_padded);  
            model_Global_padded = trainSVM(X,Y);
        end
    case 5
        if (state=='On')
            %% Train Thermal SVM 
            X=str2double(Xther);
            Y=str2double(Yther);  
            model_Thermal = trainSVM(X,Y);
        elseif (state=='Padded')    
            %% Train Thermal SVM padded 
            X=str2double(Xther_padded);
            Y=str2double(Yther_padded);  
            model_Thermal_padded = trainSVM(X,Y);
        end
    case 6
        if (state=='On')
            %% Train Lighting SVM 
            X=str2double(Xlig);
            Y=str2double(Ylig);  
            model_Lighting = trainSVM(X,Y);
        elseif (state=='Padded')    
            %% Train Lighting SVM padded 
            X=str2double(Xlig_padded);
            Y=str2double(Ylig_padded);  
            model_Lighting_padded = trainSVM(X,Y);
        end
 end   
    %% Test machines
   
    accuracy=testdata(machine,state);
 


    %% clean and save
    varcl = {'User_feelings', 'User_perceptions', 'allfiles', 'user_f', 'user_p','sensorfiles','Sensors_data', 'Sensors_info','feedback_dump', ...
             'Xglo', 'Xglo_padded', 'Xhumi', 'Xlig', 'Xlig_padded', 'Xlum', 'Xlum_padded','Xtemp','Xtemp_padded','Xther','Xther_padded',...
             'Yglo', 'Yglo_padded', 'Yhumi', 'Ylig', 'Ylig_padded', 'Ylum', 'Ylum_padded','Ytemp','Ytemp_padded','Yther','Yther_padded',...
             'model_Temperature','model_Temperature_padded','model_Humidity','model_Luminosity','model_Luminosity_padded','model_Thermal',...
             'model_Thermal_padded','model_Lighting','model_Global','model_Global_padded','accuracy'};

    clearvars('-except',varcl{:});

    save domusdata;
end
