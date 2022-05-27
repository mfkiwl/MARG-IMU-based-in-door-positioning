% PSINS Toolbox initialization.180508
% See also  glvs.
% Copyright(c) 2009-2014, by Gongmin Yan, All rights reserved.
% Northwestern Polytechnical University, Xi An, P.R.China
% 09/09/2013, 31/01/2015

initfile = dir('psinsinit.m');
if isempty(initfile) % ~strcmp(initfile.name,'psinsinit.m')
    error('Please set the current working directory to PSINS.'); 
end
%% Remove old PSINS path from search path.
pp = [';',path,';'];
kpsins = strfind(pp, 'psins');
ksemicolon = strfind(pp, ';');
krm = length(kpsins);
for k=1:krm
	k1 = find(ksemicolon<kpsins(k),1,'last');
	k2 = find(kpsins(k)<ksemicolon,1,'first');
	pk = pp(ksemicolon(k1)+1:ksemicolon(k2)-1);
	rmpath(pk);
end
%% Add new PSINS directories to search path.
rootpath = pwd;%获得当前路径
pp = genpath(rootpath);%获得当前路径以及其下子文件夹路径
mytestflag = 0;
if exist('mytest/mytestinit.m', 'file')
    mytestflag = 1;
end
datapath = [rootpath, '/data/'];

addpath(pp); %将文件夹及其子文件夹添加到搜索路径
res = savepath; % disp(res);
%% Create PSINS environment file
fid = fopen('psinsenvi.m', 'wt');
fprintf(fid, 'function [rpath, dpath, mytestflag] = psinsenvi()\n');
fprintf(fid, '\trpath = ''%s'';\n', rootpath);
fprintf(fid, '\tdpath = ''%s'';\n', datapath);
fprintf(fid, '\tmytestflag = %d;\n', mytestflag);
fclose(fid);
clear pp rootpath datapath res fid mytestflag;
glvs;
disp('   *** PSINS Toolbox Initialization Done! ***');
% msgbox('PSINS Toolbox Initialization Done!','PSINS','modal')

