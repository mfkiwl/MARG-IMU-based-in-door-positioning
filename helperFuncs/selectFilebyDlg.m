function [file,filepath] = selectFilebyDlg(glv)
% select a file by dialog (can remeber last choice)
% glv - a global variable used to store last choice, see glvf and glvs
% file - the content of the selected file, .mat
% filepath - the path of the selected file

% Xiaofeng Ma @ Aalto University

if isempty(glv.lastpath)
    rpath = glv.datapath;
else
    rpath = glv.lastpath;
end

[fileName,pathName] = uigetfile('.csv','which file?',rpath);
if isequal(fileName,0)
   error(['------ cancelld ----']);
%    clear;
   file = [];
   return;
end
disp(['------ user select: ',pathName,fileName])
filepath = [pathName,fileName];
file = xlsread([pathName,fileName],1); % Replace with other read functions if the file is not a .csv or excel.

% ---------------- record selected path -----------------
selpath = ['lpath = ''',pathName,''';'];
s = [glv.rootpath,'\psinsenvi.m'];
fileID = fopen(s,'r+');
i = 0;
while ~feof(fileID)
    tline = fgetl(fileID);
    i = i+1;
    newline{i} = tline;
    if i == 5
        newline{i} = selpath;
    end
end
fclose(fileID);
fileID = fopen(s,'w+');
fprintf(fileID,'%s\n',newline{1});    
for k=2:i
    fprintf(fileID,'%s\n',newline{k});
end
fclose(fileID);

disp(filepath);

glvs;    
end


