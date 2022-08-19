function file_dir = selectFolderbyDlg(glv)
% select a folder by dialog (can remeber last choice)
% glv - a global variable used to store last choice, see glvf and glvs
% file_dir - all the files/folders under selected folder

% Xiaofeng Ma @ Aalto University


if isempty(glv.lastpath)
    rpath = glv.datapath;
else
    rpath = glv.lastpath;
end

selpath = uigetdir(rpath,'which folder?');


if selpath == 0
   error(['------ cancelld ----']);
%    clear;
   file_dir = '';
   return;
end
disp(['------ user select: ',selpath])
file_dir = dir(selpath);

% ----------- record selected path -----------------
selpath = ['lpath = ''',selpath,''';'];
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

glvs;

end


