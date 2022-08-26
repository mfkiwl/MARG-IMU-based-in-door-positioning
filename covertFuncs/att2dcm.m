function C = att2dcm(att,order,Ctype)
% Convert Euler angles to DCM.
% b-frame pointed to rfu of the carrier.
% Prototype: Cbn = att2dcm(att, 'zyx')
% Input: att - the rotating angles from the n-frame to b-frame
%              att=[pitch; roll; yaw], rad
% Output: C - DCM, Cbn is from n-frame to b-frame
%                      i.e. Cbn = C^b_n
% Xiaofeng Ma

s = sin(att); c = cos(att);
si = s(1); sj = s(2); sk = s(3); 
ci = c(1); cj = c(2); ck = c(3);

if strcmp(order,'zxy')
    Cbn = [ cj*ck-si*sj*sk, cj*sk+si*sj*ck,  -ci*sj;
         -ci*sk,          ci*ck,           si;
         sj*ck+si*cj*sk,  sj*sk-si*cj*ck,  ci*cj];
elseif strcmp(order,'zyx')
    Cbn = [cj*ck,           cj*sk,           -sj;
           si*sj*ck-ci*sk,  si*sj*sk+ci*ck,  si*cj;
           ci*sj*ck+si*sk,  ci*sj*sk-si*ck,  ci*cj];
else
    error('Undefined order');
    
end
   
if strcmp(Ctype,'Cnb')
    C = Cbn';
elseif strcmp(Ctype,'Cbn')
    C = Cbn;
end

end
       


