function Cns = sSys2rfu(sSys)
% Calculate DCM from s-frame to rfu-frame.
% Notes:   r:right l:left f:front b:back u:up d:down

% Prototype:   Cns = s2rfuStatic('lfu')
% Input:   sSys - directiono of s-frame, should be recorded
%                        manually while doing experiments.
% Output:  DCM from s-frame to rfu-frame, vecotr_n = Cns*vecotr_s,
%               i.e. Cns = C^n_s

% by Xiaofeng Ma.
% 29/04/2020, 21/07/2020, 31/05/2022

switch sSys
    case 'dlf'
        Csn = dcm('z',-pi/2)*dcm('y',pi/2);
    case 'dfr'
        Csn = dcm('y',pi/2);
    case 'flu'
        Csn = dcm('z',pi/2);
    case 'bru'
        Csn = dcm('z',-pi/2);
    case 'rfu'
        Csn = eye(3);  
    case 'frd'
        Csn = dcm('x',pi)*dcm('z',pi/2);
    case 'luf'
        Csn = dcm('x',-pi/2)*dcm('y',pi);%or Csn = dcm('y',pi)*dcm('x',pi/2);
    case 'rub'
        Csn = dcm('x',pi/2);
%     case 'bul'
%         Csn = [0 0 1;0 1 0;-1 0 0]*[1 0 0;0 0 1;0 -1 0];
    case 'fur' 
        Csn = dcm('x',pi/2)*dcm('z',pi/2);
    case 'rdf'   
        Csn = dcm('x',-pi/2);        
    otherwise
        error('Undefined s-frame');
end
Cns = Csn';
end

function C = dcm(axis, angle)
switch axis
    case 'x'
        C = [1 0 0;0 cos(angle) sin(angle);0 -sin(angle) cos(angle)];
    case 'y'
        C = [cos(angle) 0 -sin(angle);0 1 0;sin(angle) 0 cos(angle)];
    case 'z'
        C = [cos(angle) sin(angle) 0;-sin(angle) cos(angle) 0;0 0 1];
    otherwise
        error('axis wrong')
end
end