function [accuracy]=testdata(machine,state)
    load("domusdata");

    
    %% Test feelings
switch machine
    case 1
        if isequal(state,'On')
            [Ytest_Temperature1,accuracy_Temperature1,precision_Temperature1,recall_Temperature1]=testSVM(model_Temperature,Xtemp,Ytemp);
            accuracy=accuracy_Temperature1;
        elseif isequal(state,'Padded')  
            [Ytest_Temperature1_padded,accuracy_Temperature1_padded,precision_Temperature1_padded,recall_Temperature1_padded]=testSVM(model_Temperature_padded,Xtemp_padded,Ytemp_padded);
            accuracy=accuracy_Temperature1_padded;
        end
        %     [Ytest_Temperature2,accuracy_Temperature2,precision_Temperature2,recall_Temperature2]=testSVM(model_Temperature2,Xtemp2,Ytemp2);
        %     [Ytest_Temperature2_padded,accuracy_Temperature2_padded,precision_Temperature2_padded,recall_Temperature2_padded]=testSVM(model_Temperature2_padded,Xtemp2_padded,Ytemp2_padded);

    case 2
        if isequal(state,'On')
            [Ytest_Humidity,accuracy_Humidity,precision_Humidity,recall_Humidity]=testSVM(model_Humidity,Xhumi,Yhumi);
            accuracy=accuracy_Humidity;
        elseif isequal(state,'Padded') 
        %     accuracy(1)=accuracy_Humidity;
        end

    case 3
        if isequal(state,'On')
            [Ytest_Luminosity,accuracy_Luminosity,precision_Luminosity,recall_Luminosity]=testSVM(model_Luminosity,Xlum,Ylum);
             accuracy=accuracy_Luminosity;
        elseif isequal(state,'Padded') 
            [Ytest_Luminosity_padded,accuracy_Luminosity_padded,precision_Luminosity_padded,recall_Luminosity_padded]=testSVM(model_Luminosity_padded,Xlum_padded,Ylum_padded);
             accuracy=accuracy_Luminosity_padded;
        end

    case 5
            %% Test perceptions
        if isequal(state,'On')
            [Ytest_Thermal,accuracy_Thermal,precision_Thermal,recall_Thermal]=testSVM(model_Thermal,Xther,Yther);
            accuracy=accuracy_Thermal;
        elseif isequal(state,'Padded') 
            [Ytest_Thermal_padded,accuracy_Thermal_padded,precision_Thermal_padded,recall_Thermal_padded]=testSVM(model_Thermal_padded,Xther_padded,Yther_padded);
             accuracy=accuracy_Thermal_padded;
        end
 
    case 6
       if isequal(state,'On')
            [Ytest_Lighting,accuracy_Lighting,precision_Lighting,recall_Lighting]=testSVM(model_Lighting,Xlig,Ylig);
             accuracy=accuracy_Lighting;
        elseif isequal(state,'Padded') 
            [Ytest_Lighting_padded,accuracy_Lighting_padded,precision_Lighting_padded,recall_Lighting_padded]=testSVM(model_Lighting_padded,Xlig_padded,Ylig_padded);
             accuracy=accuracy_Lighting_padded;
        end

    case 4
        if isequal(state,'On')
            [Ytest_Global,accuracy_Global,precision_Global,recall_Global]=testSVM(model_Global,Xglo,Yglo);
             accuracy=accuracy_Global;
        elseif isequal(state,'Padded')  
            [Ytest_Global_padded,accuracy_Global_padded,precision_Global_padded,recall_Global_padded]=testSVM(model_Global_padded,Xglo_padded,Yglo_padded);
            accuracy=accuracy_Global_padded;
        end
    end
end