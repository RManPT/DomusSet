function [DUMP] = makeDump()
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
end