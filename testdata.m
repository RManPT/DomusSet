function [accuracy]=testdata(machines)
    load("domusdata");

    accuracy=zeros(1,6);
    %% Test feelings
if (machines(1)=='On')
    [Ytest_Temperature1,accuracy_Temperature1,precision_Temperature1,recall_Temperature1]=testSVM(model_Temperature,Xtemp,Ytemp);
    accuracy(1)=accuracy_Temperature1;
elseif (machines(1)=='Padded') 
    [Ytest_Temperature1_padded,accuracy_Temperature1_padded,precision_Temperature1_padded,recall_Temperature1_padded]=testSVM(model_Temperature_padded,Xtemp_padded,Ytemp_padded);
    accuracy(1)=accuracy_Temperature1_padded;
end
%     [Ytest_Temperature2,accuracy_Temperature2,precision_Temperature2,recall_Temperature2]=testSVM(model_Temperature2,Xtemp2,Ytemp2);
%     [Ytest_Temperature2_padded,accuracy_Temperature2_padded,precision_Temperature2_padded,recall_Temperature2_padded]=testSVM(model_Temperature2_padded,Xtemp2_padded,Ytemp2_padded);
if (machines(2)=='On')
    [Ytest_Humidity,accuracy_Humidity,precision_Humidity,recall_Humidity]=testSVM(model_Humidity,Xhumi,Yhumi);
    accuracy(2)=accuracy_Humidity;
elseif (machines(2)=='Padded') 
%     accuracy(1)=accuracy_Humidity;
end
if (machines(3)=='On')
    [Ytest_Luminosity,accuracy_Luminosity,precision_Luminosity,recall_Luminosity]=testSVM(model_Luminosity,Xlum,Ylum);
     accuracy(3)=accuracy_Luminosity;
elseif (machines(3)=='Padded') 
    [Ytest_Luminosity_padded,accuracy_Luminosity_padded,precision_Luminosity_padded,recall_Luminosity_padded]=testSVM(model_Luminosity_padded,Xlum_padded,Ylum_padded);
     accuracy(3)=accuracy_Luminosity_padded;
end
    %% Test perceptions
if (machines(4)=='On')
    [Ytest_Thermal,accuracy_Thermal,precision_Thermal,recall_Thermal]=testSVM(model_Thermal,Xther,Yther);
    accuracy(4)=accuracy_Thermal;
elseif (machines(4)=='Padded') 
    [Ytest_Thermal_padded,accuracy_Thermal_padded,precision_Thermal_padded,recall_Thermal_padded]=testSVM(model_Thermal_padded,Xther_padded,Yther_padded);
     accuracy(4)=accuracy_Thermal_padded;
end
if (machines(5)=='On')
    [Ytest_Lighting,accuracy_Lighting,precision_Lighting,recall_Lighting]=testSVM(model_Lighting,Xlig,Ylig);
     accuracy(5)=accuracy_Lighting;
elseif (machines(5)=='Padded') 
    [Ytest_Lighting_padded,accuracy_Lighting_padded,precision_Lighting_padded,recall_Lighting_padded]=testSVM(model_Lighting_padded,Xlig_padded,Ylig_padded);
     accuracy(5)=accuracy_Lighting_padded;
end
if (machines(6)=='On')
    [Ytest_Global,accuracy_Global,precision_Global,recall_Global]=testSVM(model_Global,Xglo,Yglo);
     accuracy(6)=accuracy_Global;
elseif (machines(6)=='Padded') 
    [Ytest_Global_padded,accuracy_Global_padded,precision_Global_padded,recall_Global_padded]=testSVM(model_Global_padded,Xglo_padded,Yglo_padded);
     accuracy(6)=accuracy_Global_padded;
end
end