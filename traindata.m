load("domusdata");
load("parseddata");

%% Train Temperature SVM 1
    
    X=str2double(Xtemp);
    Y=str2double(Ytemp);  
    model_Temperature = trainSVM(X,Y);
    
%% Train Temperature SVM 1 padded
    
    X=str2double(Xtemp_padded);
    Y=str2double(Ytemp_padded);  
    model_Temperature_padded = trainSVM(X,Y);

    
%% Train Temperature SVM 2
    
    X=str2double(Xtemp2);
    Y=str2double(Ytemp2);  
    model_Temperature2 = trainSVM(X,Y);
  
%% Train Temperature SVM 2 padded
    
    X=str2double(Xtemp2_padded);
    Y=str2double(Ytemp2_padded);  
    model_Temperature2_padded = trainSVM(X,Y);
    
%% Train Humidity SVM 
    
    X=str2double(Xhumi);
    Y=str2double(Yhumi);
    model_Humidity = trainSVM(X,Y);
  
    
%% Train Luminosity SVM 
    
    X=str2double(Xlum);
    Y=str2double(Ylum);
    model_Luminosity = trainSVM(X,Y);  

%% Train Luminosity SVM padded
    
    X=str2double(Xlum_padded);
    Y=str2double(Ylum_padded);
    model_Luminosity_padded = trainSVM(X,Y);  
    
 %% Save models
 
save domusmodels 